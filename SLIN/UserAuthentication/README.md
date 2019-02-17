# User Authentication

[nsswitch.conf](https://www.dummies.com/programming/networking/network-administration-linux-nsswitch-conf-file/)  
[RHEL PAM](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/managing_smart_cards/pam_configuration_files)  
[The Linux-PAM System Administrators' Guide](http://www.linux-pam.org/Linux-PAM-html/Linux-PAM_SAG.html)  

## PAM
The checks are executed from the top to the bottom of the file.  
Config files at `/etc/pamd.d/`  
Log output `/var/log/messages` or `/var/log/secure`  
Libaries at `/lib64/security/`  

| Control Flag | Description |
|-|-|
| Requisite | On fail exit and return fail, else continue (must succeed for overall result to be Success) |
| Required | On fail continue but return fail (must succeed for overall result to be Success) |
| Sufficient | On success exit and return success, else continue (does not need to succeed for overall result to be Success) |
| Include | Includes configuration from another file |
| Optional | Pass/Fail ignored |

| Management Groups | Description |
|-|-|
| auth | identifies the user, usually by password |
| account | after identity has been checked, determines if user is allowed to access the service (eg check access times) |
| password | used when user needs to change password |
| session | handles tasks that need to be done before user is allowed to work, eg logging, mounting home directory |
[vsftpd pam file](vsftpd)  
[login pam file](login)  

## pam permit
[Man](http://www.linux-pam.org/Linux-PAM-html/sag-pam_permit.html)  
Add `auth sufficient pam_permit.so` to the top of `/etc/pam.d/login` to allow users to login without password.

## pam listfile
[Man](http://www.linux-pam.org/Linux-PAM-html/sag-pam_listfile.html)  
`/etc/vsftpd/ftpusers` contains a list of users not allowed to login to vsftpd.

## pam tally2
Edit `/etc/pam.d/login`
```
auth required pam_env.so
auth required pam_tally2.so deny=3 unlock_time=100
```
```
account required pam_unix.so
account required pam_tally2.so
```
```bash
# view failed login attempts
pam_tally2
# unlock user's account
pam_tally2 --user username --reset
```

## pam time
For vsftpd edit `/etc/pam.d/vsftpd` and add the pam_time.so line at that location.
```
auth    required    pam_shells.so
auth    include     password-auth
account required    pam_time.so
account include     password-auth
```
Edit `/etc/security/time.conf` to set the conditions.  
[Config man page](http://www.linux-pam.org/Linux-PAM-html/sag-pam_time.html)  

## sudoers
[Examples](https://www.garron.me/en/linux/visudo-command-sudoers-file-sudo-default-editor.html)
```
# allow simon to use systemctl for httpd
simon ALL=/usr/bin/systemctl * httpd
# allow simon to use systemctl for httpd and edit files in /etc/httpd/
simon ALL=/usr/bin/systemctl * httpd. /usr/bin/vim /etc/httpd/*
```
