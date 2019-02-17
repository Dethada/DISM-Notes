# System Monitoring

## Network
[tcpdump guide](https://danielmiessler.com/study/tcpdump/)  
[tcpdump examples](https://hackertarget.com/tcpdump-examples/)  
[tcpdump man](https://www.tcpdump.org/manpages/tcpdump.1.html)  
```bash
# show all tcp and udp listening ports with port number & program name
# deprecated
netstat -tupln
# ss is netstat's replacement
ss -tupln
# Capture packets on interface
tcpdump -i ens33
# captures icmp packets only, you can swap icmp with tcp and udp
tcpdump icmp -i ens33
# capture 100 packets on all interface and write to capture.pcap
tcpdump -c 100 -i any -w capture.pcap
# read pcap file
tcpdump -r capture.pcap
```

## Logging

| Facility | Description |
|---|---|
| authpriv | Security/Authorisation messages |
| cron | Clock daemons (atd and cron) |
| daemon | Other daemons |
| kern | Kernel messages |
| local[0-7] | Reserved for local use |
| lpr | Printing System |
| mail | Mail system |
| news | News system |
| syslog | Internal syslog messages |
| user | Generic user level messages |

| Priority | Description |
|---|---|
| debug | Debugging info |
| info | General info messages |
| notice | Normal but significant conditions |
| warning | Warning messages |
| err | Error condition |
| crit | Critical condition |
| alert | Immediate action required |
| emerg | System no longer available |

Config at `/etc/rsyslog.conf`  
[Sample rsyslog.conf](rsyslog.conf)
```bash
systemctl restart rsyslog
```
Send log messages
```bash
logger -p authpriv.warning "Message here"
```

## AIDE
```bash
# install aide
sudo yum install -y aide
# initalize database
aide -i -c /etc/aide.conf && mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
# compare to baseline
aide -C -c /etc/aide.conf
# update and replace database
aide -u -c /etc/aide.conf && mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
```

## swatchdog
```bash
# enable epel repo
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -O /tmp/epel.rpm && rpm -ivh /tmp/epel.rpm
# install dependencies
sudo yum install -y perl-ExtUtils-MakeMaker perl-Time-HiRes perl-Date-Calc perl-Date-Manip perl-TimeDate
# compile and install
tar –xvf swatchdog-3.2.4.tar.gz && cd swatchdog-3.2.4 && perl Makefile.PL && make && make test && make install && make realclean
# run swatchdog in the background without any output
nohup swatchdog –c /etc/swatchdog.conf –t /var/log/secure 2>&1  > /dev/null &
# kill swatchdog running in background
ps -ef | grep swatchdog.conf | grep -v grep | awk '{print $2}' | xargs kill -SIGKILL
```

## find files
[man](https://linux.die.net/man/1/find)
```
-perm -mode
              All of the permission bits mode are set for the file.   Symbolic
              modes  are accepted in this form, and this is usually the way in
              which would want to use them.  You must specify `u', `g' or  `o'
              if  you use a symbolic mode.   See the EXAMPLES section for some
              illustrative examples.
-perm /mode
              Any of the permission bits mode are set for the file.   Symbolic
              modes  are  accepted in this form.  You must specify `u', `g' or
              `o' if you use a symbolic mode.  See the  EXAMPLES  section  for
              some  illustrative  examples.  If no permission bits in mode are
              set, this test matches any file (the idea here is to be  consis‐
              tent with the behaviour of -perm -000).
```
```bash
# find suid files
find / -perm /2000
# find sgid files
find / -perm /4000
# find files with 777 (strict match)
find / -perm 777
# find files owned by invalid user id
find / -nouser
# find files modified in the last day
find / -mtime -1
# find files modified within last 60mins
find / -mmin -60
```

## lsof
[man](https://linux.die.net/man/8/lsof)
```bash
# list open files in /tmp
lsof +D /tmp
# list files opened by network related processes
lsof -n -i
# list files opened by ipv4 network related processes
lsof -n -i 4
# list files opened by pid
lsof -p <pid>
# get pid of process
ps -ef | grep <process> | head -1 | awk '{print $2}'
pgrep <process> | head -1
```

## System Usage
[df vs du](https://unix.stackexchange.com/questions/45771/df-vs-du-why-so-much-difference)  
[Why are there so many different ways to measure disk usage?](https://unix.stackexchange.com/questions/120311/why-are-there-so-many-different-ways-to-measure-disk-usage)  
```bash
# disk usage with file system type and in human readable format
df -Th
# get folder size with du
du -sh /home/*
# cpu and disk utilizations, -N flag for logical volume disk utilization
iostat
# virtual memory stats
vmstat
# cpu activity
sar
# network stats on each network interface
sar -n DEV
```

## Process Limits
[Resource Limits](resource-limits.html)  
[Sample limits.conf](limits.conf)
`/etc/security/limits.conf`
```bash
man limits.conf
man ulimit
# list all limits of user
ulimit -a
# set the limit of maximum process to 20
ulimit -u 20
```

## Process accounting
```bash
sudo yum install -y psacct
systemctl start psacct
# check daily connect times for each user
ac -dp
# show last commands run by user
lastcomm <user>
```
