## SELinux Demo WalkThru

### Requirements
* Minimum VM: 1vCPU x 1G mem, running RHEL 7.latest or RHEL 8.latest or RHEL 9.latest

### WalkThru
* Setup via selinux-setup.sh
  * Installs & starts Apache, installs setroubleshoot-server
  * Will need root or sudo to install packages

* The setup script creates three web pages for this demo:
  * The Control Page which is just links to the other two pages.  It is at the root of your web server (e.g. http://test-system/index.html)
  * The Booleans page will demonstrate the manipulation of SELinux boolean values
  * The Labeling page will demonstrate the editing of SELinux labels

SELinux Booleans
  * Access the Booleans page, it should present and error and generate a SELinux event
  * Investigate the SELinux event:
```
# sealert -a /var/log/audit/audit.log
```
  * It should provide this command to run to resolve the SELinux boolean issue:
```
# setsebool -P httpd_read_user_content 1
```
  * Access the Booleans page again and it should load successfully

SELinux Labels
  * Access the Labels page, it should present an error and generate a SELinux event
  * Investigate the SELinux event:
  ```
  # sealert -a /var/log/audit/audit.log
  ```
  * It should provide this command to run to resolve the SELinux labeling issue:
  ```
  # /sbin/restorecon -v /var/www/html/shadow.html
  ```
  * Access the Labels page again and it should load successfully
