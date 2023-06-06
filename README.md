# demo-SELinux
Quick demo of SELinux tools, capabilities, and troubleshooting.

### Notes
SELinux is built into the RHEL kernel, so there is nothing to install for SELinux itself.  However there are tools and configuration to help with SELinux management.

This package will help make the logfiles easier to interpret and give suggestions to solve any SELinux errors:

``` # yum install setroubleshoot-server```

Tools and More
  * Show overall SELinux status: ```# sestatus```
  * Toggle the runtime mode between Permissive and Enforcing:  ```# setenforce```
  * Show current runtime mode (can be used in scripts to determine current mode): ```# getenforce```
  * File that sets boot time status and mode: ```/etc/sysconfig/selinux```
  * View SELinux booleans, use (-a) to view all booleans: ```# getsebool```
  * Used to toggle a boolean value: ```# setsebool```

Viewing SELinux labels
  * Files and dirs: ```# ls -lZ```
  * Processes: ```# ps auxZ```
  * Open Ports: ```# lsof -i -Z```

Troubleshooting
  * Logfile where SELinux logs any violations, however it is not very user friendly: ```/var/log/audit/audit.log```
  * Command part of setroubleshoot-server package that will analyze audit.log and make user friendly suggestions for resolution: ```# sealert -a /var/log/audit/audit.log```

Changing SELinux labels -- most common SELinux issues can be resolved by toggling booleans (via setsebool) or editing SELinux labels.
  * Files and dirs
```
# semanage fcontext -a -t {file_label} '/path/to/use(/.*)?'
# restorecon -Rv /path/to/use
```
  * Ports
```
# semanage port -a -t {port_label} -p tcp|udp {port_num}
```

### References and Resources
* [Red Hat Documentation - RHEL 7](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/index)
* [Red Hat Documentation - RHEL 8](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/using_selinux/)
* [Red Hat Documentation - RHEL 9](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/using_selinux/index)
