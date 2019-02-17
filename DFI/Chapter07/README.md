# Chapter 7

## What Data to Collect and Analyze
Examining and analyzing digital evidence depend on the nature of the investigation and the amount of data to process

**Scope creep - when an investigation expands beyond the original description**
- Because of unexpected evidence found
- Attorneys may ask investigators to examine other areas to recover more evidence
- Increases the time and resources needed to extract, analyze, and present evidence

Scope creep has become more common as criminal investigations require more detailed examination of evidence just before trial to help prosecutors fend off attacks from defense attorneys.

New evidence often isn’t revealed to prosecution. It’s become more important for prosecution teams to ensure they have analyzed the evidence exhaustively before trial.

## Approaching Digital Forensics Cases
Begin a case by creating an investigation plan that defines the:
- Goal and scope of investigation
- Materials needed
- Tasks to perform

The approach you take depends largely on the type of case you’re investigating Corporate, civil, or criminal.

**Follow these basic steps for all digital forensics investigations**

1. For target drives, use recently wiped media that have been reformatted and inspected for viruses
2. Inventory the hardware on the suspect’s computer, and note condition of seized computer
3. For static acquisitions, remove original drive and check the date and time values in system’s CMOS
4. Record how you acquired data from the suspect drive
5. Process drive’s contents methodically and logically
6. List all folders and files on the image or drive
7. Examine contents of all data files in all folders
8. Recover file contents for all password-protected files
9. Identify function of every executable file that doesn’t match hash values
10. Maintain control of all evidence and findings

Refining and Modifying the Investigation Plan. Even if initial plan is sound, at times you may need to deviate from it and follow evidence. Knowing the types of data to look for helps you make the best use of your time. The key is to start with a plan but remain flexible in the face of new evidence.

## Validating Forensic Data
- Ensuring the integrity of data collected is essential for presenting evidence in court
- Most forensic tools offer hashing of image files
- Example - when ProDiscover loads an image file it runs a hash and compares the value with the original hash calculated when the image was first acquired

## Data-Hiding Techniques
Data hiding - changing or manipulating a file to conceal information

**Techniques**
- Hiding entire partitions
- Changing file extensions
- Setting file attributes to hidden
- Bit-shifting
- Using encryption
- Setting up password protection

### Hiding Partitions
By using the Windows diskpart remove letter command you can unassign the partition’s letter, which hides it from view in File Explorer to unhide, use the diskpart assign letter command.

To detect whether a partition has been hidden account for all disk space when examining an evidence drive analyze any disk areas containing space you can’t account for.

### Marking Bad Clusters
A data-hiding technique used in FAT file systems is placing sensitive or incriminating data in free or slack space on disk partition clusters

Can mark good clusters as bad clusters in the FAT table so the OS considers them unusable only way they can be accessed from the OS is by changing them to good clusters with a disk editor.

## Steganalysis
Steganalysis - term for detecting and analyzing steganography files.

Steganalysis methods
- Stego-only attack
- Known cover attack
- Known message attack
- Chosen stego attack
- Chosen message attack