# Digital Signatures

An authentication mechanisum that enables the creator of a message to attach a code that acts as a signature. The signature is formed by taking the hash of the message and encrypting it with the creator's private key. The signature guarantees the source and integrity of the message.

Provides authentication of the message content, allow 3rd parties to verify and non-repudiation.

## Requirements
- Verifys message integrity
- Can only be created by the sender (Non-repudiation)
- Relatively easy to produce
- Relatively easy to recognise & verify
- Computationally infeasible to forge
- Practical to save digital signature in storage

## Applications
Sign documents, files, emails, certificates.

## Direct Digital Signatures
Involve only sender & receiver. Sign first then encrypt message & signature

Validity of signature depends on sender's private key.
- Sender may deny sending the message. (Private Key stolen)
- Timestamp on message is not useful (Might be back dated)

## Arbitrated Digital Signatures
Invites a third party into the process called a trusted arbiter.

**Use of a arbiter**
- Receiver signed messages from sender
- Validate content & origin from subject, message and signature
- Dated the message and indicate that the message have been verified
- Sent to recipient(s)

Aribiter may or may not see the message. Suitable level of trust in arbiter required.

**Requires**
- Complete trust from both sender and reciever that the arbiter will only time stamp and forward the document as instructed, but also not alter the data in any way.
- Prevent sender from disowning message

## Digital Signature Schemes
The scheme defines there 3 algorithms
- Key generation algorithm
- Signature algorithm
- Signature verification algorithm

### Digital Signature Standard (DSS)
US Govern approved signature scheme designed by NIST & NSA in early 90's published as FIPS-186 in 1991 revised in 1993, 1996 & then 2000.

Uses the SHA hash algorithm

DSS is the standard, DSA is the algorithm

### Digital Signature Algorithm (DSA)
[Wiki](https://en.wikipedia.org/wiki/Digital_Signature_Algorithm)

Based on asymmetric key algorithm (discrete logarithm). 320 bit signature, 512-1024 bit key.

Smaller and faster than RSA.
