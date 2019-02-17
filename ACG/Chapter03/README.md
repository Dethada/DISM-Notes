# AES

[Paper](https://nvlpubs.nist.gov/nistpubs/fips/nist.fips.197.pdf)  
[OpenSSL Source Code](https://github.com/openssl/openssl/blob/master/crypto/aes/aes_core.c)  
[Comic](http://www.moserware.com/2009/09/stick-figure-guide-to-advanced.html)  

| Key Length | Number of rounds | Block Size |
|-|-|-|
| 128 | 10 | 128 |
| 192 | 12 | 128 |
| 256 | 14 | 128 |

Higher key length means more CPU time.

A Word in this case is a group of 32 bits that is treated either as a single entity or as an array of 4 bytes.

Operation order
1. Key Expansion
2. Inital Round (Only AddRoundKey)
3. Rounds
    - SubBytes, ShiftRows, MixColumns, AddRoundKey
4. Final Round
    - SubBytes, ShiftRows, AddRoundKey

## SubBytes
A simple byte subsititution with a [S-Box](https://en.wikipedia.org/wiki/Rijndael_S-box)

**Provies Confusion**

## ShiftRows
Circular byte shift in each row
- 1st row is unchanged
- 2nd row does 1 byte shift to left
- 3rd row does 2 byte shift to left
- 4rd row does 3 byte shift to left

**Provies Diffusion**

## MixColumns
[Wiki](https://en.wikipedia.org/wiki/Rijndael_MixColumns)

Matrix multiplication for each word.

**Provies Diffusion**

## AddRoundKey
XOR state with 128 bit round key.

Each byte of the state is combined with a byte of the round subkey using the XOR operation (⊕).

## Key Expansion
Takes 128 bit key and expands into array of 44 (4 x (10+1)) words. To form 11 round keys.

The first round key is the original 128 bits.

### Rationale
- Knowing partial key is insufficient to find many more.
- Invertible transformation
- Fast on wide range of CPU's
- Use round constants (RCON) to break symmetry
- diffuse key bits into round keys
- enough non-linearity to hinder analysis
- simplicity of description

## Decryption
Inverse cipher with steps as for encryption, but using inverses of each step with a different key schedule.

1. Add Round key
2. Inverse sub bytes
3. Inverse shift rows
4. Inverse mix cols