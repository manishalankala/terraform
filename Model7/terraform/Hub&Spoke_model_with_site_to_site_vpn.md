

# Hub & Spoke model with site to site vpn

![image](https://user-images.githubusercontent.com/33985509/124583009-e1afa000-de52-11eb-9bb9-1084fddf7b12.png)


Site-2-Site VPN Gateway — the actual Azure component that sends encrypted traffic between an Azure virtual network and your on-premise VPN router

Public IP address — Azure public IP address associated with the VPN Gateway

Local Network Gateway — a logical representation of your on-premise VPN router

VPN Connection — configures the link between the VPN Gateway and Local Network


Requirements :

1.VPN device = you need to have VPN device in on-premises to create the VPN connection with azure
  Link - https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices
  
2.Static Public IP address = your VPN device should have external public IP address and it shouldn’t be NAT.

3.Azure Subscription =  you need active Azure subscription
