## SELinux Demo WalkThru

### Requirements
* Minimum VM: 1vCPU x 1G mem, running RHEL 7.latest

### WalkThru
* Setup via selinux-setup.sh
  * Installs & starts Apache, installs setroubleshoot-server
  * Creates several test web pages
  * Will need root or sudo to install packages

* What to install -- SELinux is built into the RHEL kernel, so there is nothing to install for SELinux itself.  However there are tools and configuration to help with SELinux management.
'yum install setroubleshoot-server' -- this package will help make the logfiles easier to interpret and give suggestions to solve any SELinux errors

* Tools and more
# sestatus -- shows overall SELinux status
# setenforce -- quickly toggles the runtime mode between Permissive and Enforcing
# getenforce -- shows current runtime mode (can be used in scripts to determine current mode)
/etc/sysconfig/selinux -- file that sets boot time status and mode
# getsebool -- view SELinux booleans, use (-a) to view all booleans
# setsebool -- used to toggle the boolean value

* Viewing SELinux labels
  * Files and dirs: # ls -lZ
  * Processes: # ps auxZ
  * Open Ports: lsof -i -Z

* Troubleshooting
/var/log/audit/audit.log -- where SELinux logs any violations, however it is not very user friendly
# sealert -a /var/log/audit/audit.log -- command part of setroubleshoot-server package that will analyze audit.log and make user friendly suggestions for resolution

* Changing SELinux labels -- most common SELinux issues can be resolved by toggling booleans (via setsebool).  The other option is to edit SELinux labels
  * Files and dirs
```
# semanage fcontext -a -t {file_label} '/path/to/use(/.*)?'
# restorecon -Rv /path/to/use
```
  * Ports
```
# semanage port -a -t {port_label} -p tcp|udp {port_num}
```
