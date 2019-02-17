# Samba
[Sample config](smb.conf)  
[Sample Minmum config](smb.min.conf)  
```bash
# install samba
sudo yum install -y samba
# install samba client
sudo yum install -y samba-client
# You need to add your hostname to your `/etc/hosts`
sudo echo "127.0.0.1   `hostname`" >> /etc/hosts
# Add password for user
smbpasswd –a <username>
# List shares on server
smbclient –L <serverIP>
# Access smb share as anon user
smbclient //<serverIP>/myshare
# Access smb share as user
smbclient //<serverIP>/myshare -U user
```
[Samba config file man](https://www.samba.org/~ab/output/htmldocs/manpages-3/smb.conf.5.html)

### SELinux
```bash
# set file context
chcon -R -t samba_share_t /path/to/share
# share the user home directories
setsebool -P samba_enable_home_dirs 1
```
[SELinux/Samba](https://fedoraproject.org/wiki/SELinux/samba)

## Automatic mounting
```bash
# required to mount smb shares
sudo yum install -y cifs-utils
mkdir /sambamnt
printf "user=tom\npass=tom123" > /etc/sambauser && chmod 600 /etc/sambauser
sudo echo '//<server ip>/myshare /sambamnt   cifs   credentials=/etc/sambauser  0 0' >> /etc/fstab
```