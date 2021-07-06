
## Hub & Spoke model with point to site vpn



![image](https://user-images.githubusercontent.com/33985509/124522706-7cc55d00-ddf4-11eb-9e13-39649bc5a09e.png)


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
