# Chapter 4

## Storage Formats for Digital Evidence
Data in a forensics acquisition tool is stored as an image file, there are three formats.
- Raw format
- Proprietary formats
- Advanced Forensics Format (AFF)

### Raw Format
Makes it possible to write bit-stream data to files

Advantages
- Fast data transfers
- Ignores minor data read errors on source drive
- Most computer forensics tools can read raw format

Disadvantages
- Requires as much storage as original disk or data
- Tools might not collect marginal (bad) sectors

### Proprietary Formats
Most forensics tools have their own formats

Features offered
- Option to compress or not compress image files
- Can split an image into smaller segmented files
- Can integrate metadata into the image file

Disadvantages
- Inability to share an image between different tools
- File size limitation for each segmented volume

The Expert Witness format is unofficial standard

### Advanced Forensics Format
Developed by Dr. Simson L. Garfinkel as an open-source acquisition format.

Design goals
- Provide compressed or uncompressed image files
- No size restriction for disk-to-image files
- Provide space in the image file or segmented files for metadata
- Simple design with extensibility
- Open source for multiple platforms and OSs
- Internal consistency checks for self-authentication

File extensions include .afd for segmented image files and .afm for AFF metadata

## Determining the Best Acquisition Method

2 Types of acquisitions: Static acquisitions and live acquisitions

**Four methods of data collection**
- Creating a disk-to-image file
- Creating a disk-to-disk
- Creating a logical disk-to-disk or disk-to-data file
- Creating a sparse data copy of a file or folder

Determining the best method depends on the circumstances of the investigation

**Creating a disk-to-image file**
- Most common method and offers most flexibility
- Can make more than one copy
- Copies are bit-for-bit replications of the original drive
- ProDiscover, EnCase, FTK, SMART, Sleuth Kit, X-Ways, iLookIX

**Creating a disk-to-disk**
- When disk-to-image copy is not possible
- Tools can adjust disk’s geometry configuration
- EnCase, SafeBack, SnapCopy

**Logical acquisition or sparse acquisition**
- Can take several hours; use when your time is limited
- Logical acquisition captures only specific files of interest to the case
- Sparse acquisition collects fragments of unallocated (deleted) data
- For large disks
- PST or OST mail files, RAID servers

**When making a copy, consider**
- Size of the source disk
    - Lossless compression might be useful
    - Use digital signatures for verification
- When working with large drives, an alternative is using tape backup systems
- Whether you can retain the disk

## Contingency Planning for Image Acquisitions
- Create a duplicate copy of your evidence image file
- Make at least two images of digital evidence
    - Use different tools or techniques
- Copy host protected area of a disk drive as well
    - Consider using a hardware acquisition tool that can access the drive at the BIOS level
- Be prepared to deal with encrypted drives
    - Whole disk encryption feature in Windows called BitLocker makes static acquisitions more difficult
    - May require user to provide decryption key

## Acquisition Tools
Advantages
- Make acquiring evidence from a suspect drive more convenient
- Especially when used with hot-swappable devices

Disadvantages
- Must protect acquired data with a well-tested write-blocking hardware device
- Tools can’t acquire data from a disk’s host protected area
- Some countries haven’t accepted the use of write-blocking devices for data acquisitions

Acquisition tools for Windows
Mini-WinFE, ProDiscover, FTK Imager

## Validating Data Acquisitions
Validating evidence may be the most critical aspect of computer forensics
Requires using a hashing algorithm utility CRC-32, MD5, and SHA-1 to SHA-512

### Windows Validation Methods
- Windows has no built-in hashing algorithm tools for computer forensics but Third-party utilities can be used.
- Commercial computer forensics programs also have built-in validation features
- Each program has its own validation technique
- Raw format image files don’t contain metadata
- Separate manual validation is recommended for all raw acquisitions

### Remote Network Acquisition
You can remotely connect to a suspect computer via a network connection and copy data from it.

**Drawbacks**
- Antivirus, antispyware, and firewall tools can be configured to ignore remote access programs
- Suspects could easily install their own security tools that trigger an alarm to notify them of remote access intrusions
