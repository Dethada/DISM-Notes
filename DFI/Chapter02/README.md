# Chapter 2

## Systematic Approach

**Steps for problem solving**
1. Make an initial assessment about the type of case you are investigating
2. Determine a preliminary design or approach to the case
3. Create a detailed checklist
4. Determine the resources you need
5. Obtain and copy an evidence drive
6. Identify the risks
7. Mitigate or minimize the risks
8. Test the design
9. Analyze and recover the digital evidence
10. Investigate the data you recover
11. Complete the case report
12. Critique the case

### Assessing the Case

**Systematically outline the case details**
- Situation
- Nature of the case
- Specifics of the case
- Type of evidence
- Known disk format
- Location of evidence

### Planning

**A basic investigation plan should include the following activities**
- Acquire the evidence
- Complete an evidence form and establish a chain of custody
- Transport the evidence to a computer forensics lab
- Secure evidence in an approved secure container

**A basic investigation plan**
- Prepare your forensics workstation
- Retrieve the evidence from the secure container
- Make a forensic copy of the evidence
- Return the evidence to the secure container
- Process the copied evidence with computer forensics tools

**Evidence Custody Form**
Helps you document what has been done with the original evidence and its forensics copies. **Single-evidence** form lists each piece of evidence on a separate page. **Multi-evidence** form lists multiple pieces of evidence on one page.

### Securing Evidence
Use evidence bags to secure and catalog the evidence. Computer safe products when collecting computer evidence. Use well padded containers.
- Antistatic bags
- Antistatic pads

Use evidence tape to seal all openings of CD drive bays, insertion slots for power supply cords and USB cables.

Write your initials on tape to prove that evidence has not been tampered with.

Consider computer specific temperature and humidity ranges. Make sure you have a safe environment for transporting and storing it until a secure evidence container is available.

## Private-Sector Digital Investigations
As an investigator, you need to develop formal procedures and informal checklists 
- To cover all issues important to high-tech investigations
- Ensures that correct techniques are used in an investigation

The majority of investigative work for termination cases involves employee abuse of corporate assets and incidents that create a hostile work environment.
- Viewing pornography in the workplace
- Sending inappropriate e-mails

### Internet Abuse Investigations

**To conduct an investigation you need**
- Organization’s Internet proxy server logs
- Suspect computer’s IP address
- Suspect computer’s disk drive
- Your preferred computer forensics analysis tool

**Recommended steps**
- Use standard forensic analysis techniques and procedures
- Use appropriate tools to extract all Web page URL information
- Contact the network firewall administrator and request a proxy server log
- Compare the data recovered from forensic analysis to the proxy server log
- Continue analyzing the computer’s disk drive data

### Email Abuse Investigations

**To conduct an investigation you need**
- An electronic copy of the offending e-mail that contains message header data
- If available, e-mail server log records
- For e-mail systems that store users’ messages on a central server, access to the server
- Access to the computer so that you can perform a forensic analysis on it
- Your preferred computer forensics analysis tool

**Recommended steps**
- Use the standard forensic analysis techniques
- Obtain an electronic copy of the suspect’s and victim’s e-mail folder or data
- For Web-based e-mail investigations, use tools such as FTK’s Internet Keyword Search option to extract all related e-mail address information
- Examine header data of all messages of interest to the investigation

### Attorney-Client Privilege Investigations
Under attorney-client privilege (ACP) rules for an attorney, you must keep all findings confidential.

Many attorneys like to have printouts of the data you have recovered. You need to persuade and educate many attorneys on how digital evidence can be viewed electronically.

You can also encounter problems if you find data in the form of binary files.

**Steps for conducting an ACP case**
- Request a memorandum from the attorney directing you to start the investigation
- Request a list of keywords of interest to the investigation
- Initiate the investigation and analysis
- For disk drive examinations, make two bit-stream images using different tools for each image
- Compare hash signatures on all files on the original and re-created disks
- Methodically examine every portion of the disk drive and extract all data
- Run keyword searches on allocated and unallocated disk space
- For Windows OSs, use specialty tools to analyze and extract data from the Registry
- For binary data files such as CAD drawings, locate the correct software product
- For unallocated data recovery, use a tool that removes or replaces nonprintable data
- Consolidate all recovered data from the evidence bit-stream image into folders and subfolders

**Other Guidelines**
- Minimize written communications with the attorney
- Any documentation written to the attorney must contain a header stating that it’s "Privileged Legal Communication — Confidential Work Product"
- Assist the attorney and paralegal in analyzing data

### Industrial Espionage Investigations
All suspected industrial espionage cases should be treated as criminal investigations.

**Staff needed**
- Computing investigator who is responsible for disk forensic examinations
- Technology specialist who is knowledgeable of the suspected compromised technical data
- Network specialist who can perform log analysis and set up network sniffers
- Threat assessment specialist (typically an attorney)

**Guidelines**
- Determine whether this investigation involves a possible industrial espionage incident
- Consult with corporate attorneys and upper management
- Determine what information is needed to substantiate the allegation
- Generate a list of keywords for disk forensics and sniffer monitoring
- List and collect resources for the investigation
- Determine goal and scope of the investigation
- Initiate investigation after approval from management

**Planning considerations**
- Examine all e-mail of suspected employees
- Search Internet newsgroups or message boards
- Initiate physical surveillance
- Examine facility physical access logs for sensitive areas
- Determine suspect location in relation to the vulnerable asset
- Study the suspect’s work habits
- Collect all incoming and outgoing phone logs

**Steps to conducting an industrial espionage case**
- Gather all personnel assigned to the investigation and brief them on the plan
- Gather resources to conduct the investigation
- Place surveillance systems at key locations
- Discreetly gather any additional evidence
- Collect all log data from networks and e-mail servers
- Report regularly to management and corporate attorneys
- Review the investigation’s scope with management and corporate attorneys

## Interviews and Interrogations in High-Tech Investigations

**Interview**  
Usually conducted to collect information from a witness or suspect, about specific facts related to an investigation

**Interrogation**  
Process of trying to get a suspect to confess

A computing investigator needs to instruct the investigator conducting the interview on what questions to ask and what the answers should be.

**Ingredients for a successful interview or interrogation**
- Being patient throughout the session
- Repeating or rephrasing questions to zero in on specific facts from a reluctant witness or suspect
- Being tenacious

## Data Recovery

Investigations are conducted on a computer forensics lab (or data-recovery lab). In data recovery, the customer or your company just wants the data back.

**Computer forensics workstation**  
A specially configured PC
Loaded with additional bays and forensics software

To avoid altering the evidence use:  
Write-blockers devices which enable you to boot to read data without writing data to the evidence drive.

**Basic requirements** 
- A workstation running Windows XP or later
- A write-blocker device
- Digital forensics acquisition tool
- Digital forensics analysis tool
- Target drive to receive the source or suspect disk data
- Spare PATA or SATA ports
- USB ports

**Useful Items**
- Network interface card (NIC)
- Extra USB ports
- FireWire 400/800 ports
- SCSI card
- Disk editor tool
- Text editor tool
- Graphics viewer program
- Other specialized viewing tools

## Conducting an Investigation

**Items needed**
- Original storage media
- Evidence custody form
- Evidence container for the storage media
- Bit-stream imaging tool
- Forensic workstation to copy and examine your evidence
- Securable evidence locker, cabinet, or safe

**Gathering evidence** 
- Meet the IT manager to interview him
- Fill out the evidence form, have the IT manager sign
- Place the evidence in a secure container
- Carry the evidence to the computer forensics lab 
- Complete the evidence custody form
- Secure evidence by locking the container

**Bit-stream copy**  
Bit-by-bit copy of the original storage medium, different from a simple backup copy.  
Backup software only copy known files, cannot copy deleted files, e-mail messages or recover file fragments
Copy image file to a target disk that matches the original disk’s manufacturer, size and model

**Bit-stream image**  
File containing the bit-stream copy of all data on a disk or partition, also known as "image" or "image file".

### Acquiring an Image of Evidence Media
Conduct your analysis only on a copy of the data.

Several vendors provide MS-DOS, Linux, and Windows acquisition tools
Windows tools require a write-blocking device when acquiring data from FAT or NTFS file systems

### Analyzing Digital Evidence
Your job is to recover data from:
Deleted files
File fragments
Complete files
Deleted files linger on the disk until new data is saved on the same physical location

Data analysis can be most time-consuming task

## Completing a Case

You need to produce a final report and state what you did and what you found. Have repeatable findings repeat the steps and produce the same result. If required, use a report template. Report should show conclusive evidence. Eg. suspect did or did not commit a crime or violate a company policy.

Keep a written journal of everything you do as your notes can be used in court.

Answer the six Ws: Who, what, when, where, why, and how

You must also explain computer and network processes

## Critiquing a Case
Ask yourself the following questions:
- How could you improve your performance in the case?
- Did you expect the results you found? Did the case develop in ways you did not expect?
- Was the documentation as thorough as it could have been?
- What feedback has been received from the requesting source?
- Did you discover any new problems? If so, what are they?
- Did you use new techniques during the case or during research?