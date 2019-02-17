# Mail

| Component | Description |
|-|-|
| Mail Transport Agent (MTA) | MTA receives mails and attempts to deliver them based on destination address (eg sendmail, postfix, exim) |
| Mail Delivery Agent (MDA) | MDA received mails for local delivery and delivers the mail to users’ mailboxes (eg procmail) |
| Mail User Agent (MUA) | MUA retrieves mail from user’s mailbox and presents it to user. MUA also transfer user’s outgoing mail to MTA for delivery (eg mutt, thunderbird) |

| Relay | Description |
|-|-|
| Open Relay | will receive mail from any source and forward to any destination |
| Closed Relay (default) | refuse to relay mail from anyone and will only accept mail destined for local users|
| Mostly Closed Relay | accepts mail destined for local users and willing to relay for select clients |

## Postfix
[Sample Config file](main.conf)  
[Basic Config](http://www.postfix.org/BASIC_CONFIGURATION_README.html)  
[Config Parameters](http://www.postfix.org/postconf.5.html)  
Config file at `/etc/postfix/main.cf`
```bash
# install postfix
sudo yum install -y postfix
# view config file man for master.cf
man 5 master
# listen on all interfaces, remember to restart postfix to apply changes
postconf 'inet_interface=all'
# might fix host not found error
postconf 'smtp_host_lookup=dns,native'
# relay mails for all hosts in network
postconf 'mynetworks=172.16.180.0/24'
```
[Host not found error](https://www.howtoforge.com/community/threads/name-service-error-for-name-localhost-localdomain-type-a-host-not-found.27151/)

To accept emails from other domains add it to the `mydestination` variable in `/etc/postfix/main.cf`

## Sending and recieving Mails
```bash
# mail local user alice, ctrl-D to finish the message
mail alice
# mail remote user alice
mail alice@client.example.com
# check mail queue
sudo mailq
# re-try delivery of mails immediately
postfix flush
# check mailbox
mail
```

## Mail alias
Config at `/etc/aliases`  
Format: `alias_name: email_id1, email_id2, ...`
```bash
# reload the aliases
newaliases
```