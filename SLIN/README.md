# Secure Linux
## GUI Install
```bash
curl https://raw.githubusercontent.com/PotatoDrug/SLIN/master/getgui.sh | bash
```
## Tmux is bae
```bash
curl https://raw.githubusercontent.com/PotatoDrug/SLIN/master/gettmux.sh | bash
```

## User
Add user (with home directory)  
`useradd <username>`  
`useradd <username> -G <secondary groups>`  

Add group  
`groupadd <name>`  

Add user to group  
`usermod -a -G <groups> <user>`  

change user default shell  
`chsh -s /sbin/nologin`  

Delete user  
`deluser -r <username>`  

ACL might come in handy.  

## Network Configuration
Check centos version: `cat /etc/centos-release`  
DNS config: `/etc/resolv.conf`  
Our lord and saviour  
`nmtui`  

show interface information
`nmcli d show`  
`nmcli d show <interface name>`  

### Netstat
```bash
# Show tcp and udp listening ports
netstat -tupln
# Show all active tcp and udp ports
netstat -tunap
```
## SELinux
GUI: `yum install policycoreutils-gui`  
`system-config-selinux`  

Check SELinux mode  
`getenforce`  

Set SELinux mode  
`setenforce <0/1>`  

View all SELinux booleans    
`getsebool -a`  

Set SELinux boolean  
`setsebool -P <bool> <on/off>`  

List current SELinux port type  
`semange port –l`   

Show SELinux context of files  
`ls -Z`  

Change file context  
`chcon -t shadow_t /path/to/file`    

Restore original file context   
`restorecon /path/to/file`  

## Kernel Parameters
List all parameters  
`sysctl -a`  
Write parameter  
`sysctl -w <parameter>`  
[Examples](http://www.tutorialspoint.com/unix_commands/sysctl.htm)  

## SSH
Config location: `/etc/ssh/sshd_config`   
`scp <server>:/get/this/file /save/to/here`  

### SELinux
To tell selinux to not mess with your custom port  
`> semanage port –a –t ssh_port_t –p tcp <port>`  
## VSFTPD
Config location: `/etc/vsftpd/vsftpd.conf`  
Folder location: `/var/ftp/`  
ftp server: `yum install vsftpd`  
ftp client: `yum install ftp`  
```
firewall-cmd --permanent --zone=public --add-service=ftp
firewall-cmd --reload
```  

root login is disabled by default.  
vsftpd by default allows users to login and browse the entire system as long as their permission allows. chroot confines the user to their own home directory.  
```
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list
allow_writeable_chroot=YES
passwd_chroot_enable=YES
```
[Dangers of allow_writable_chroot=YES](https://unix.stackexchange.com/questions/323711/what-are-the-dangers-of-having-writable-chroot-directory-for-ftp/332571#332571)  
Add the users you want to chroot to `/etc/vsftpd/chroot_list`  
> If passwd_chroot_enable=YES, along with chroot_local_user , then a chroot() jail location may be specified on a per-user basis. Each user's jail is derived from their home directory string in /etc/passwd. The occurrence of /./ in the home directory string denotes that the jail is at that particular location in the path.  
`student:x:1000:1000:student:/home/./student:/bin/bash`  

[Config manpage](http://vsftpd.beasts.org/vsftpd_conf.html)

Upload only directory
```
mkdir /var/ftp/upload
chmod 730 /var/ftp/upload
```

### SELinux
```bash
# allow anon upload to folder
chcon -t public_content_rw_t /path/to/folder
setsebool -P ftpd_anon_write on
# to allow access for user home dirs
setsebool –P ftp_home_dir on
```

## Apache HTTPD
Config location: `/etc/httpd/conf/httpd.conf`  
Site config: `/etc/httpd/conf/site.conf`  
Default access log: `/var/log/httpd/access_log`  
Default error log: `/var/log/httpd/error_log`  
`yum install httpd`  

```
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
```  

Deny access to all except from 127.0.0.1 and 192.168.1.1  
```
<VirtualHost *:80>
    ServerName mysite.com
    ServerAlias www.mysite.com
    
    DocumentRoot /var/www/html/site
    <Directory /var/www/html/site>
        Options -Indexes
        Require all denied
        Require ip 127.0.0.1 192.168.1.1
    </Directory>
    
    # Possible values include: debug, info, notice, warn, error, crit, alert, emerg.
    LogLevel warn
    
    ErrorLog /path/to/error_log
    CustomLog /path/to/access_log combined
</VirtualHost>
```
[Config](https://httpd.apache.org/docs/2.4/sections.html)  
[Core](https://httpd.apache.org/docs/2.4/mod/core.html)  
[Virtual Host Examples](https://httpd.apache.org/docs/2.4/vhosts/examples.html)  
### Basic Authentication
```bash
# add -c to create the file
htpasswd -cm /etc/httpd/conf/mysite-users alice
# -c not required if file is already created
htpasswd -m /etc/httpd/conf/mysite-users bob
```
.htaccess configuration
```
AuthType basic
AuthName "My Site"
AuthUserFile /etc/httpd/conf/mysite-users
require user alice bob
```
[More on .htaccess](https://httpd.apache.org/docs/2.4/howto/htaccess.html)  

### SSL
Config location: `/etc/httpd/conf.d/ssl.conf`  
Private key: `/etc/pki/tls/private/localhost.key`  
Certificate: `/etc/pki/tls/certs/localhost.crt`  

`yum install mod_ssl`  
[More](http://httpd.apache.org/docs/2.2/mod/mod_ssl.html)  

### CGI Scripts
Install python3.6  
```bash
curl https://raw.githubusercontent.com/PotatoDrug/SLIN/master/getpy3.sh | bash
```
To allow execution of cgi-bin scripts  
```bash
# change context for single script
chcon -t httpd_sys_script_exec_t /path/to/script
# change context for folder
chcon -R -t httpd_sys_script_exec_t /path/to/cgi-bin
```
[SELinux file contexts for httpd](https://fedoraproject.org/wiki/SELinux/apache)  
[More on cgi scripts](https://httpd.apache.org/docs/2.4/howto/cgi.html)  

## Squid
Config location: `/etc/squid/squid.conf`
`yum install squid`
Remember the order of the rules matters, the higher rule will override the rules below. The following configuration will allow everyone from admins to access bad_sites, while blocking everyone else.  
```
acl admins src 192.168.1.1-192.168.1.20
acl bad_sites dstdomain .bing.com
acl bad_sites dstdomain .yahoo.com
http_access allow admins
http_access deny bad_sites
```
[More](http://cottagedata.com/security/squid/squid.html)  
[Config](http://www.squid-cache.org/Doc/config/)  

## Tomcat
Config location: `/etc/tomcat/`  
Webapp location: `/var/lib/tomcat/webapps`  
`yum install tomcat`  

To shutdown tomcat using port 8005  
```bash
echo 'SHUTDOWN' | nc 127.0.0.1 8005
```

## NFS
Config location: `/etc/exports`  
if not installed: `yum install nfs-utils`  
`systemctl start nfs-server`  

Refresh exports according to `/etc/exports`  
`exportfs -rv`  

View exported directories  
`exportfs -v`  

> Allow tcp connections on port 2049 and connections to loopback interface (enabled by default)

`firewall-cmd --permanent --zone=public --add-service=nfs`  

[Config Options](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/deployment_guide/s1-nfs-server-config-exports)  
[Man page](https://linux.die.net/man/5/exports)  

### Mounting
```bash
# mount all exported directories
mount <server>:/ /mount/target -o rw
# mount specified directory
mount <server>:/exported/dir /mount/target
```

## Firewall daemon
```bash
systemctl start firewalld
firewall-cmd --list-all-zones
firewall-cmd –-get–default-zone
# list all services and ports and rich rules configured on the zone
firewall-cmd --zone=public --list-all  
# list configured services
firewall-cmd --list-services  
# list configured ports
firewall-cmd --zone=public --permanent --list-ports
firewall-cmd --permanent --zone=public --add-service=telnet  
firewall-cmd --permanent --zone=public --remove-service=telnet 
firewall-cmd --zone=public --add-port=5000/tcp  
firewall-cmd --zone=public --permanent --add-port=4990-4999/udp  

firewall-cmd --reload  
```
For outgoing traffic we have to use direct rules.
```bash
firewall-cmd --direct --get-all-rules  

# Add Direct rules
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 99 -j DROP  
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 1 –m state --state ESTABLISHED,RELATED -j ACCEPT  
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 2 -p tcp --dport 80 -j ACCEPT  
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 2 -p tcp --dport 443 -j ACCEPT  
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 3 -p udp --dport 53 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 4 -p udp –d 192.168.1.10 --dport 9000 -j DROP

# Remove direct rules
firewall-cmd --direct --remove-rule ipv4 filter OUTPUT 1 –m state --state ESTABLISHED,RELATED -j ACCEPT  
firewall-cmd --direct --remove-rule ipv4 filter OUTPUT 2 -p tcp --dport 80 -j ACCEPT  
firewall-cmd --direct --remove-rule ipv4 filter OUTPUT 3 -p udp --dport 53 -j ACCEPT  
firewall-cmd --direct --remove-rule ipv4 filter OUTPUT 99 -j DROP 
``` 

[More](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-7)   
[Rich rules](https://www.linode.com/docs/security/firewalls/introduction-to-firewalld-on-centos/#rich-rules)  
[Man Page](https://firewalld.org/documentation/man-pages/firewall-cmd.html)  
[Rich Rules Man page](https://firewalld.org/documentation/man-pages/firewalld.richlanguage.html)  
[Wiki](https://fedoraproject.org/wiki/Firewalld?rd=FirewallD)  

## TCP Wrapper
> Because access rules in hosts.allow are applied first, they take precedence over rules specified in hosts.deny. Therefore, if access to a service is allowed in hosts.allow, a rule denying access to that same service in hosts.deny is ignored.
> 
> The rules in each file are read from the top down and the first matching rule for a given service is the only one applied. The order of the rules is extremely important.
> 
> If no rules for the service are found in either file, or if neither file exists, access to the service is granted.
>
> TCP-wrapped services do not cache the rules from the hosts access files, so any changes to hosts.allow or hosts.deny take effect immediately, without restarting network services.

[Less](https://www.tecmint.com/secure-linux-tcp-wrappers-hosts-allow-deny-restrict-access/)  
[More](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-tcpwrappers.html)  

## Misc
Get UUID of partition  
`blkid /dev/sda1`  

[Sed tutorial](https://www.digitalocean.com/community/tutorials/the-basics-of-using-the-sed-stream-editor-to-manipulate-text-in-linux)  
[AWK Tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-the-awk-language-to-manipulate-text-in-linux)   
[xargs tutorial](https://shapeshed.com/unix-xargs/)  
