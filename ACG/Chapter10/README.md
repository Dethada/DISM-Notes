# Pretty Good Privacy

PGP is a program to secure electronic mail to ensure **Privacy** and **Authenticity**.

## PGP Popularity
PGP is available free worldwide.

Available on a variety of platforms including Windows, *nix, OSX and more.

PGP is based on algorithms that have survived extensive public review and are considered extremely secure.

PGP has a wide range of applicability.

PGP was not developed by, nor is it controlled by, any governmental or standards organisation.

## Features
- Encryption of messages, digests and keys
- message digest used for digital signature
- key generation for private session key
- key generation for users' key pairs
- key management and certification cyclic redundancy check (CRC)

## Email Security Objectives
- Privacy/Encryption
- Message Integrity
- Authentication
- Non-repudiation

## Public Keys
PGP maintains a list of public keys that the user has obtained by one means or another.

Each item on public key ring includes several parts listed below
- The public key itself
- The user ID of the owner of this public key
- A key ID (UID for the public key)
- Other information related to the trustworthiness of the key and its owner.

## Private Keys
It is stored on the user's private key ring.

Recommended to store this private key ring on a secure USB for security reasons.

To access the key, a passphrase is required. PGP then uses that passphrase to generate a 128 bit IDEA (International Data Encryption Algorithm) key and encrypts the private key using the chosen algorithm and the passphrase-based key.

Each private key includes the following information
- The encrypted private key
- Owner's user ID
- A copy of the matching public key

## Order of Operations
- Create key pair
- Exchange public key with others
- Validate your keys
- Sign and encrypt your email and files
- Decrypt and verify your email and files

## Operational Description
The actual operation of PGP for sending and receiving messages, consists of the following 5 services
- Digital Signature
- Message Encryption
- Compression
- E-mail Compatibility
- Segmentation and Reassembly

Digital Signature and Message encryption can be used together to provide confidentiality and authenticity. The signature is first generated for the plaintext message and added to the message. Then the plaintext+signature is encrypted.

### Digital Signature
1. Sender creates the message
2. PGP generates hash of the message (SHA1)
3. Sender specifies the private key to be used for this operation.
4. PGP encrypts the hash with the sender's private key and the result is prepended to the message. (RSA)
5. Receiver uses sender's public key to decrypt and recover the hash code.
6. Receiver generates new hash code, if the 2 match the message is accepted as authentic.

### Message Encryption
A new session key is generated as a random 128 bit number for each message. This key is only used once, bound to the message transmitted with it. It is encrypted with the reciever's public key.

The symmetric encryption algorithms available are CASE-128, IDEA and 3DES.

### Compression
By default PGP compresses the message with **ZIP** after applying the signature but before encryption.

Data compression reduces redundancy thereby enhancing resistance to cryptanalysis.

### Radix-64 Conversion
Many electronic mail systems only allow messages made of ASCII text, raw binary data is not supported. Radix-64 converts the plaintext by expanding block of 24 bits into 4 printable ASCII characters (32 bits).

The message grows by about 33 percent, but it was probably compressed more than that by PGP before it was encrypted.

### Segmentation and Reassembly
Electronic mail facilities often are restricted to a maximum message length. Any message longer than the pre-specified size must be broken up into smaller segments, each of which is mailed separately. PGP automatically subdivides message that is too large into segments that are small enough to send via email.

The segmentation is done after all other processing including Radix-64 conversion.

The session key component and signature component appear only once at the beginning of the first segment.

At the receiving end, PGP strips off all email header and reassemble the entire original block before performing any other operations.