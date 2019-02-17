# RSA

[Wiki](https://en.wikipedia.org/wiki/RSA_(cryptosystem))

[Number Theory](https://www.youtube.com/watch?v=fq6SXByItUI)

## Coprime
2 integers a and b are said to be relatively prime, mutually prime or coprime if the only positive integer (factor) that divides both of them is 1.

gcd(a,b) = 1

## Key Generation
1. Choose 2 distinct primes **p** and **q**.
2. Compute **n = pq**.

3. **phi(n) = (p-1)(q-1)**
4. choose e: ( 1 < e < phi(n) ) && coprime with phi(n)

> In practice we choose e first then check if p-1 and q-1 is coprime with e.
> If e is prime, then you only need to check that it isn't a factor in (p-1) and not a factor in (q-1).

5. Choose d where `de (mod phi(n)) = 1` use extended euclidean algorithm `gcd(phi(n), e)`.

### EEA Alternative
`d=(1+x*m)/e `  
So that x is a positive integer.  
Increment x until a integer is returned.  

for example :  
`(1+3*40)/7=17.2 `  
Do not take because 17.2 is not a integer  
`(1+4*40)/7=161/7=23 `  
then d=is 23   
this is take because is a integer  

```python
i = 1
e = 131
phi_n = 288
while True:
    d = (1+i*phi_n) / e
    if (d.is_integer()):
        print('Found d: {}'.format(d))
        break
    i+=1
```

## Encryption
m^e mod n

## Decryption
m^d mod n