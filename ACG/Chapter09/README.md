# Key Distribution

Typical ways public keys are distributed
- Public announcement
- Publicly Available directory
- Public key authorithy
- Public key certificate

## Public Announcement
Users distribute public keys to recipients or broadcast to community at large
- Append PGP keys to email messages
- Post PGP keys on news groups or email list
- Various site that support PGP keys as part of user profile (Eg. facebook)

Convenient and works well for small sacle distribution but anyone can create a key claiming to be someone else and broadcast it. Adversary can masquerade as claimed user until discovered.

## Publicly Available Directory
Directory must be trusted with properties
- contains {name,public key} entries
- participants register securely with directory
- participants can replace key at any time
- directory is periodically published
- directory can be accessed electronically
- directory must be trusted

Greater security as compared to **Public announcement** but still vulnerable to tampering or forgery by pretending to be an authorised directory or change records in directory.

## Public Key Authorithy
A central authority maintains a dynamic directory of public keys of all participants. Improved security over public directory method.

### Requirements
- Authority must be secured
- All users must know the public key of the directory (authority) with only the authority knowing the corresponding private key.
- Real-time access to directory when keys are needed.

### Issues
- Authority can become a bottleneck
- Records maintained can also be tempered with

## Public Key Certificates
To overcome bottleneck in **Public key authorithy** we can use public-key certificates.
- Allow key exchange without real time access to public key authority
- Binds identity to public key with other info such as period of validity, rights of use etc.

Public-key signed by a trusted **Certificate Authority (CA)** can be verified by anyone. Public key of CA is publicly available.

### Certificate
A certificate is the ID and public key of a user signed by the CA.

Time stamp validates currency of certificate (expiration date)

Common format for certificates is X.509 standard by ITU
- S/MIME (secure email)
- IP security (network layer security)
- SSL/TLS (transport layer security)
- SET (e-commerce)

# Diffie-Hellman Key Exchange
[Wiki](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)

If the public key is properly secured in a central directory (aka with PKI) other users could query the public key, compute the secret key and communicate. Authentication of user is possible (because of PKI).

### Attacks
- Replay attacks (with/without PKI)
- MITM attacks (without PKI)
