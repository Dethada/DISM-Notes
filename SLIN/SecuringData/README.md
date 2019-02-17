# Securing Data

## PRNG
[/dev/random vs /dev/urandom](https://unix.stackexchange.com/questions/324209/when-to-use-dev-random-vs-dev-urandom)
```bash
# generate number of random bytes
openssl rand <num of bytes>
# generate number of random bytes in b64
openssl rand -base64 <num of bytes>
```

## Hasing
for the commands below md5sum can be replaced with sha1sum or sha256sum
```bash
md5sum /tmp/testfile > checksum.md5
md5sum /tmp/* > tmpchecksums.md5
# verify the integrity of files
md5sum --check tmpchecksums.md5
```

## Symmetric Encryption
Add -base64 flag to the commands below if you want the output to be in base64
```bash
openssl des3 -in msg -out ciphertext
openssl des3 -d -in ciphertext -out plaintext
```

## Asymmetric Encryption
[GPG Command references](https://www.gnupg.org/gph/en/manual/r590.html)
### Key Management
[GPG Manual](https://www.gnupg.org/gph/en/manual/c235.html)
[More](https://www.tutonics.com/2012/11/gpg-encryption-guide-part-1.html)
The -a flag is for ascii armoured input/output
```bash
gpg --gen-key
gpg --list-keys
gpg --list-secret-keys
# <Name> is the name you entered during key generation
gpg -a --export <Name> > pubkey.asc
gpg -a --import pubkey.asc
```

### Encryption and Decryption
[More](https://www.tutonics.com/2012/11/gpg-encryption-guide-part-2-asymmetric.html)
```bash
# Encrypt with <Name>'s public key, <Name> can also be the keyid
gpg -a -r <Name> -e plaintext.txt -o ciphertext
# Decrypt with your private key
gpg -a -d ciphertext -o msg.txt
```

### Digital Signatures
[GPG Manual](https://www.gnupg.org/gph/en/manual/x135.html)
[More](https://www.tutonics.com/2012/11/gpg-encryption-guide-part-3-digital.html)
```bash
# Encrypt with <Name>'s public key and sign with your private key
gpg -r BobTan -a -s -e msg -o signedmsg
# Decrypt the encrypted signed message.
gpg -a -d signedmsg -o msg
```

## Certificates
[OpenSSL](https://wiki.openssl.org/index.php/Command_Line_Utilities)  
[Common OpenSSL Commands](https://www.sslshopper.com/article-most-common-openssl-commands.html)  
[CA Convinence Script](https://linoxide.com/security/make-ca-certificate-authority/)  
[CA Serial numbers](https://crypto.stackexchange.com/questions/257/unpredictability-of-x-509-serial-numbers)  
`/etc/pki/tls/openssl.cnf`

### CA Setup
Manual
```bash
openssl genrsa -aes256 -out /etc/pki/CA/private/cakey.pem 4096 && chmod 600 /etc/pki/CA/private/cakey.pem
openssl req -x509 -new -nodes -key /etc/pki/CA/private/cakey.pem -sha256 -days 1825 -out /etc/pki/CA/cacert.pem
touch /etc/pki/CA/index.txt && echo 01 > /etc/pki/CA/serial
```
Convinence Script
```bash
# generates a 2048bit rsa key
/etc/pki/tls/misc/CA -newca
```

### Generate and Sign Certificate
Manual
```bash
# generate site private key and csr
openssl req -out /etc/pki/CA/certs/server.csr -new -newkey rsa:4096 -nodes -keyout /etc/pki/CA/private/server.key
# create the signed certificate
openssl x509 -req -in /etc/pki/tls/certs/server.csr -CA /etc/pki/CA/cacert.pem -CAkey /etc/pki/CA/private/cakey.pem -CAserial /etc/pki/CA/serial -out /etc/pki/tls/certs/server.crt -days 1825 -sha256
```
Convinence Script
```bash
/etc/pki/tls/misc/CA -newreq
/etc/pki/tls/misc/CA -sign
```

### HTTPD Config
/etc/httpd/conf.d/ssl.conf
```
SSLCertificateFile /etc/pki/tls/certs/server.crt
SSLCertificateKeyFile /etc/pki/tls/private/server.key
```

## SSH Keys
`$HOME/.ssh/` Perms 700
`$HOME/.ssh/id_rsa` Perms 600
`$HOME/.ssh/id_rsa.pub` Perms 644
`$HOME/.ssh/authorized_keys` Perms 600
```bash
# Generate new rsa ssh key
ssh-keygen -t rsa
# Creates .ssh dir if it does not exist and sets proper permissions
# Then add the public key to authorized_keys file
cat ~/.ssh/id_rsa.pub | ssh user@<server> "mkdir -p ~/.ssh && chmod 700 ~/.ssh ; cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

## SSH Agent
```bash
eval $(ssh-agent -s)
ssh-add
```

## SSH Tunneling
[More](https://blog.trackets.com/2014/05/17/ssh-tunnel-local-and-remote-port-forwarding-explained-with-examples.html)  
Set `AllowTCPForwarding yes` in `/etc/ssh/sshd_config`

### Local Port Forwarding
If you want to make it look like the traffic is coming from the server.
```bash
# tunnels port 8000 on localhost to localhost:80 through server
ssh -L 8000:localhost:80 user@server
# tunnels port 8000 on localhost to google.com:80 through server
ssh -L 8000:google.com:80 user@server
```
### Remote Port Forwarding
The server will be something like a reverse proxy.
```bash
# tunnels port 3000 on server to local port 9000 through server
ssh -R 9000:localhost:3000 user@server
```

## VNC
Server
```bash
# install vnc server
sudo yum install -y vnc-server
# configure service file
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@.service
sed -i 's/<USER>/test/g' /etc/systemd/system/vncserver@.service
# run this as the user specified in the vncserver service file
vncpasswd
# reload service files
systemctl daemon-reload
# start the service
systemctl start vncserver@:1
```
Client
```bash
# install vnc client
sudo yum install -y vnc
# connect to server
vncviewer server_IP:1
# connect through ssh
vncviewer –via <server> localhost:1
```