

openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365

Ubuntu and Debian - sudo apt install openssl

Centos and Fedora - sudo yum install openssl


openssl req -newkey rsa:4096 -x509 -sha256 -days 5000 -nodes -out example.crt -keyout example.key

ls

or 

openssl req -newkey rsa:4096 -x509 -sha256 -days 5000 -nodes -out example.crt -keyout example.key -subj "CN=www.example.com" 
