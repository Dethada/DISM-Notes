# DNS

| Record Type | Description |
|-|-|
| A | IPv4 address |
| AAAA | IPv6 address |
| CNAME | Used to assign DNS aliases |
| MX | Mail exhcange record |
| NS | Nameserver for the domain |
| PTR | Used for reverse lookups |
| SOA | Start of Authority, contains the Primary DNS server |

[Recursive vs Iterative DNS](https://sg.godaddy.com/help/what-risks-are-associated-with-recursive-dns-queries-1184)

## BIND
Config file at `/etc/named.conf`  
Zone files at `/var/named/`
```bash
sudo yum install -y bind bind-utils
systemctl enabled named && systemctl start named
# dns query
dig www.sp.edu.sg
host -a www.sp.edu.sg
# reverse dns lookup
dig -x <ip addr>
host -a <ip addr>
# zone transfer
dig axfr example.com
# check zone file
named-checkzone example.com example.com.zone
# check reverse zone file
named-checkzone 180.16.172.in-addr.arpa reverse.zone
```
FQDN end with a dot in the dns zone files  
[sample named.conf](named.conf)  
[sample zone file](example.com.zone)  
[sample reverse zone file](example.com.rev.zone)  
[Zone has no NS records error](https://serverfault.com/questions/465646/zone-has-no-ns-records-error-while-setting-up-subdomain)  

You can add dns servers using `numtui`   
To change dns manually edit `/etc/NetworkManager/NetworkManger.conf` and add `dns=none` and run `systemctl restart NetworkManger`, then edit `/etc/resolv.conf` and set nameserver to ip of the the dns server you want.
