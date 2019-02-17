# iOS Devices

iPhone has 2 processors, first one works on GSM connection, the second runs the OS.

**Process of acquisition is performed in 2 steps**
- OS image is received from the device
- OS image is parsed and investigated

## Partitions
- MBR
- Apple_Free area
- OS partition
    - Generally 500MB
    - Uses the HFSX file system
- Apple_Free area
- Data Partition

## Operating System

### Core Layers
Core OS and Core services layer contain the fundamental interfaces for iPhone OS, including:
- accessing files
- low level data types
- Bonjour services
- network sockets

### Core Services
- Core Foundation
- CFNetwork
- SQLite
- access to POSIX threads and UNIX sockets

### Media Layer
OpenAL, Audio Mixing and Recording, Video playback, image formats, quartz, core animation, OpenGLES

### Cocoa Touch
Managing of the multi-touch events and controls, use of accelerometer, view hierarchy, localization and use of embedded camera

## Apps
Each App is isolated in a sandbox.

- Creates Home Directory
    - `<Application_Home>/AppName.app`
- User Data
    - `<Application_Home>/Documents/`
- Outside Access
    - `<Application_Home>/InBox`
- Temporary Files
    - `<Application_Home>/tmp`

## Typical Users Home Directory

- **Application** - User specific Apps
- **Desktop** - Contains items on desktop
- **Documents** - Contains users documents and files
- **Downloads** - Contains what they have downloaded from the internet
- **Library** - Contains user specific App files (Hidden)
- **Movies** - Contains user video files
- **Music** - Contains user music files
- **Pictures** - Contains user photos
- **Public** - Contains contents user wants to share
- **Site** - Contains web pages used by the user

## Jailbreaking
- Root access to OS
- opens up all the security on the device
- no sandbox for apps
- no security patches
- able to use device on any carrier
- opens device for malware/spyware

## iPhone Forensics Evidence
- EXIF data
- Plist files
- Desktop backups
- Device data/backup
- Security blocks

## iOS Handling Procedures
1. Use Gen 2 Faraday protection
    - Copper lining in interior seal
2. Charge Device 100%
3. Plan for LONG acquisition time
    - Depending on device acquisition time can range from minutes to over 8 hours.
4. Look for backup records on computer

## Acquisition

### Logical
- Does backup of user oriented files
- does not access primary file system of device
- does recover deleted data

If the device is jailbroken, more data can be acquired.

Acquires the following data
- Address Book
- SMS history
- Call history
- iMessages
- Calendar
- Notes
- File system
- Map Bookmarks/history/directions
- mac address

## EXIF
**Exchangeable image file format** is a standard that specifies the formats for images, sound and ancillary tags used by digital cameras, scanners and other systems handling image and sound files recorded by digital cameras.

## Images
Images are named in numerical order
```
IMG_0065.jpg
IMG_0066.jpg
IMG_0067.jpg
```
The thumbnail will be in the same folder with `.thm` extension. Eg. `IMG_0065.thm`

## Plist Files
File storage containing information on cache, history and configuration settings. These files need to be examined for evidence.

Email uses html headers consider running a keyword search instead of `.html`. Also look in the envelope index file `/private/var/root/library/mail/envelope Idenx`.

### Locations
- Maps - `/private/var/root/library/maps/history.plist`
- Maps - `/private/var/root/library/maps/route.plist`
- Network - `/private/var/root/library/preferences/systemconfiguration/com.apple.network.identification.plist`
- Cookies - `/private/var/root/library/cookies/cookies.plist`
- Bookmarks - `/private/var/root/library/safari/bookmarks.plist`

## Words typed into the device
Similar to predicitive text files in other models of phones. Stores words spelled into the device at `/private/var/root/library Key board/dynamictext.dat`.

## Notes
`/private/var/root/library/notes.db`

## Voice Mail
Specific details are recoverable
- Senders phone number
- Call back number
- Time stamp
- Message duration
- Date/time moved to trash

`/private/var/root/library/voicemail/voicemail.db`

## Passwords
Password of the OS is at `/private/etc/passwd`

The root and mobile passwords are encrypted using a DES algorithm.

## iTunes sync
- Photo
- Music
- Call logs
- Calendar
- Email
- Bookmarks

### Information Available
- Serial number with iTunes
- IMEI (International Mobile Equipment Identity)
- ICCID (Intergrated Circuit Card ID) SIM Number
- Date and Time of Connection

## iPhone Recovery Mode
- Sleep/Wake and Home Buttons - Hold 25 seconds

## iPhone Security
- Arm Processor
- Used to only allow applications lauched in Safari
- Passwords
    - Phone (can be brought back to home iTunes)
    - SIM PIN
    - Known default root password

### Security Design
- Secure Boot Chain
- App cide signing
- runtime process security

### Device Access
- Passcode protection
- Configuration enforcement
- Mobile Device management
- Device restrictions
- Remote wipe
