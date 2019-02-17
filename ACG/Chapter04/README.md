# Modes of Operation

[Wiki](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation)

Used to handle arbitrary amounts of data in practise to improve security. It describes how to repeatedly apply a cipher's single-block operation securely to transform amounts of data larger than a block.

Applicable for block and stream modes.

- ECB
- CBC
- CFB
- OFB
- CTR

## Message Padding
Pad with extra bits at the last block as follows:
- pad with known non-data value (eg nulls)
- pad with bits + count of pad size
    - Eg. [b1 b2 b3 00 00 00 00 05]
    - 3 data bytes, then 5 bytes pad + count

Need to recognise padding at the receiving end.

## Electronic Code Book (ECB)
Simplest mode of operation, message is split into individual blocks and encrypted independently with the same key. Used when for encrypting single block of information.

### Limitations
- Deterministic
- Message repetition shows in ciphertext.

## Cipher Block Chaining (CBC)
Cipher blocks are linked together. Each previous block is chained with the next plaintext block, hence called cipher block chaining.

**Initalization Vector (IV)** is used to start the process. IV is usually random or non-repeating. It ensures different ciphertext blocks will be generated even though the same plaintext blocks appear multiple times in the message.

![CBC Encryption](CBC_encryption.png)
![CBC Encryption](CBC_decryption.png)

### Features
A ciphertext block depends on all blocks before it, not just the key. Any change to a block affects all following ciphertext blocks providing an avalanche effect.

## Cipher Feedback (CFB)
Allows any number of bits to be feedbacked, most efficient when all bits in block are used. Used in stream data encryption, authentication.
![CFB Encryption](CFB_encryption.png)
![CFB Decryption](CFB_decryption.png)

### Advantages
- Most appropriate when data arrives in bits/bytes (stream mode).

### Limitations
- Will stall during block encryption after every n-bits if cant keep up with input data.
- Error propagate for several blocks.

## Output Feedback (OFB)
Output of cipher is added to message stream, output is then feedback to the next cycle independent of message.

Use In: stream encryption on noisy channels.

![OFB Encryption](OFB_encryption.png)
![OFB Decryption](OFB_decryption.png)

### Advantage
- Bit errors do not propagate. Single bit error in ciphertext only affect 1 bit in plaintext.

### Limitations
- Must never reuse same key+IV
- Based on research it is more optimum to use Full block feedback, OFB-64 or OFB-128

## Counter (CTR)
Similar to OFB but encrypts counter value rather than any feedback value. Requires a different key or counter value for every plaintext block.

Use in: High-speed network such as ATM encryptions

![CTR Encryption](CTR_encryption.png)
![CTR Decryption](CTR_decryption.png)

### Advantage
- Efficiency (Parallelizable encryption and decryption)
- Provable security

### Limitation
- Breakable if there is key/counter reuse.