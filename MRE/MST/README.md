# MRE MST

## Q1 Summary of malware
> 12 Marks

Write 3 Points, worth 4 Marks each.

## Q2 Static Analysis
> 20 Marks

- MD5 hash
- File size
- Packer used (if applicable)
- Type of PE (Definitely PE32 because the WinXP VM is 32-bit)
- Subsystem (CFF Explorer -> Optional Header -> Subsystem)

Also give the hash and file size for the unpacked version if applicable.

## Q3 File System Activities
> 6 Marks

At least 3/4 things about file Read/Write/Delete/Move.

Refer to [Procmon Filters](#procmon-filters).

## Q4 Processes & Services
> 8 Marks

- Number of Instances (4 marks)
- Child processes spawned (4 marks)
- Any other related info

> Note: For this exam the process has a weird/not oustanding name.

Using Procmon you can see what processes the malware spawns, do this by clicking the icons at the top to hide other activities and only show process and thread activity, for more detailed filtering refer to [Procmon Filters](#procmon-filters).

## Q5 Registry
> 8 Marks

Write down at least 1 or 2 observations. For each observation write down the key and value.

Refer to [Procmon Filters](#procmon-filters).

## Q6 Network Activity
> 18 Marks

Whatever network activity you observe from the malware.

## Q7 Mutex & Strings
> 10 Marks

- At least 3 strings (System Internals Tools -> strings.exe)
- At least 2 Mutex (Process monitoring Tools -> Process Hacker 2)

## Volatility Questions

### Identifying Image Profile
To get the profile of the image, most likely it will be `WinXPSP3x86` (The WinXP VM's profile). By default volatility uses `WinXPSP2x86` as the profile which should work fine for the exam, but to be safe you should check the profile of the image with `imageinfo` and specify the profile yourself.
```bash
volatility -f dump.raw imageinfo # Identify information for the image
```

### List Proccess
> 6 Marks

```bash
volatility --profile=WinXPSP3x86 -f dump.raw psxview # Find hidden processes with various process listings
volatility --profile=WinXPSP3x86 -f dump.raw pslist # Print all running processes by following the EPROCESS lists
volatility --profile=WinXPSP3x86 -f dump.raw psscan # Pool scanner for process objects
```

### List Ports & Protocols
> 6 Marks

Pool scanner commands can find artifacts from previous connections that have since been terminated, in addition to the active ones.
```bash
volatility --profile=WinXPSP3x86 -f dump.raw connscan # Pool scanner for open  tcp connections
volatility --profile=WinXPSP3x86 -f dump.raw sockscan # Pool scanner for listening sockets for any protocol (TCP, UDP, RAW, etc)
```

Non-pool scanner version walks the singly-linked list of their respective structures pointed to by a non-exported symbol in the tcpip.sys module.
```bash
volatility --profile=WinXPSP3x86 -f dump.raw connections # For open  tcp connections
volatility --profile=WinXPSP3x86 -f dump.raw sockets # For listening sockets for any protocol (TCP, UDP, RAW, etc)
```

[Command Reference](https://github.com/volatilityfoundation/volatility/wiki/Command-Reference#networking)

### Find Child Processes
> 6 Marks
```bash
volatility --profile=WinXPSP3x86 -f dump.raw pstree # Print process list as a tree
```

### Dumping process
> Don't think it will be tested
```bash
# normal way of extracting, supply the pid with -p
volatility --profile=WinXPSP3x86 -f dump.raw procdump --memory -p 616 -D dumps/
# if the process is not in EPROCESS lists, supply the physical offset with -o
volatility --profile=WinXPSP3x86 -f dump.raw procdump --memory -o 0x023551b0 -D dumps/
```

## Getting Memory Dump
> Don't think it will be tested

1.	Start Kernel Detective from Start &rarr; Processing Monitoring Tools &rarr; Kernel Detective.
2.	From the application menu Tools &rarr; Physical Memory Dumper &rarr;  Dump All Physical Memory.

## Procmon Filters

To apply the filters shown on this table
- Operation is `operation` then Include
- Detail begins with `detail` then Include

| Operation | Detail | Shown |
|---|---|---|
| WriteFile | Offset: | Data being written to file |
| ReadFile | Offset: | Data being read from file |
| CreateFile | Desired Access: Generic | File handles opened for reading/writing |
| RegCreateKey | Desired Access: Write | Registry keys created with no values set |
| RegSetValue |  | Registry values set |
| RegDeleteKey | | Deleted registry keys |
| RegDeleteValue | | Deleted registry values |
| Process Create | | Processes created |
| Process Start | Parent PID: `PID` | Processes started by that `PID` |

## Procedure
1. Start remnux and run `ircd start && fakedns`.
> httpd start is not required because apache is already started on boot, but you should confirm it yourself.
2. Start WinXP and set network settings to point to remnux.
3. Copy the malware over to WinXP.
4. Unpack the malware if applicable and answer Q2. (Static analysis)
5. Take a snapshot on WinXP.
6. On remnux launch wireshark and start capturing on `eth0`.
7. Start procmon and apply filters, run the malware.
8. Answer Q7. (Mutex & Strings)
9. Stop monitor and save the procmon log.
10. Copy out the procmon log, revert snapshot and copy the procmon log back in and take a new snapshot.
11. On remnux stop wireshark capture and save it, answer Q6. (Network analysis)
12. Answer Q3 & Q4 & Q5 using the procmon log. (File & registry activities, Processes & Services)
13. Anwser Volatility questions.