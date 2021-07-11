

# Hub & Spoke model with site to site vpn

![image](https://user-images.githubusercontent.com/33985509/124583009-e1afa000-de52-11eb-9bb9-1084fddf7b12.png)


Site-2-Site VPN Gateway — the actual Azure component that sends encrypted traffic between an Azure virtual network and your on-premise VPN router

Public IP address — Azure public IP address associated with the VPN Gateway

Local Network Gateway — a logical representation of your on-premise VPN router

VPN Connection — configures the link between the VPN Gateway and Local Network


## Requirements :

1. VPN device = you need to have VPN device in on-premises to create the VPN connection with azure

    Link - https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices
  
2. Static Public IP address = your VPN device should have external public IP address and it shouldn’t be NAT.

3. Azure Subscription =  you need active Azure subscription


## Steps

Step 1:  Create Virtual Network 

~~~
Name – Name for the VNet
Address Space – IP range for the VNet. If you have multiple Address ranges, it can add later. 
Subnet name – Name for the subnet you like to add 
Subnet Address range – Subnet IP range (it must be within the Address Space listed before)
Resource Group – Can create new group or select existing group
Location – location of the VNet
~~~

Step 2 : Create Gateway Subnet 

~~~
vnet name
subnet cidr range

~~~

Step 3 : Create Virtual Network Gateway

~~~
Name – Name for the virtual network gateway
Gateway Type – For our VPN it will be VPN                             = [ 1. VPN 2. Express Route ]
VPN Type – Type of the VPN and regular VPN will be route-based        = [ 1. Route based 2. Policy based ]
SKU – SKU for the VPN type
Virtual Network – in here select the VNet you have created following previous step
Public IP Address – VPN need to have public IP address. Select public IP from here or if you don’t have, once you click on the option it will allow you to add new one. 
Location – make sure you select the correct region to match with VNet region. 
~~~

Step 4 : Create Local Network Gateway

~~~
Name – Name for the local gateway 
IP Address – Public IP address to represent your VPN device. It should not behind NAT. 
Address Space – This is yours on premises address ranges. You can add multiple ranges.
Resource Group – you can create new resource group or use the same one you were using
~~~

Step 5 : Create Site-to-Site VPN

~~~
Name – Name of the connection 
Connection Type – Type of the VPN. Most of the time its site-to-site
Virtual Network Gateway – you need to select the relevant virtual network gateway
Local Network Gateway – in here need to select the relevant local network gateway for your connection
Shared Key – This is the pre-shared key you going to use for the VPN configuration
~~~
