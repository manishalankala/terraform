
![image](https://user-images.githubusercontent.com/33985509/159330207-2f16eaac-149b-4d4e-9a2b-c6254975968f.png)


## Self signed certificate

openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365

Ubuntu and Debian - sudo apt install openssl

Centos and Fedora - sudo yum install openssl


openssl req -newkey rsa:4096 -x509 -sha256 -days 5000 -nodes -out example.crt -keyout example.key

ls

or 

openssl req -newkey rsa:4096 -x509 -sha256 -days 5000 -nodes -out example.crt -keyout example.key -subj "CN=www.example.com" 


Ref:

https://docs.microsoft.com/en-us/azure/vpn-gateway/point-to-site-vpn-client-configuration-azure-cert#linuxinstallcli

https://tidbytez.com/2021/03/08/how-to-create-a-self-signed-root-certificate-and-configure-a-point-to-site-azure-vpn-connection/
