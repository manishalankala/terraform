
Steps :

go to express route circuit to get the __servicekey__

copy the service and send to service provider for provisioning.

Once the service provider has provisioned we can see the connections under (express route circuit - connections)





After Service provider provisions then

![image](https://user-images.githubusercontent.com/33985509/124996733-bf33a780-e049-11eb-8d9e-812023afb5dc.png)

![image](https://user-images.githubusercontent.com/33985509/124996900-0fab0500-e04a-11eb-9ed2-15ada54145eb.png)

![image](https://user-images.githubusercontent.com/33985509/124996967-27828900-e04a-11eb-9482-4356bf3f0fcc.png)




azurerm_express_route_circuit_peering
~~~
To connect private peering needs 
1. peer asn 
2. Primary subnet /30 
3. Secondary subnet /30
4. VLAN ID 
5. Shared key 
~~~


In terraform we need

~~~
1. azurerm_virtual_wan
2. azurerm_virtual_hub
3. azurerm_express_route_gateway
4. azurerm_express_route_port
5. azurerm_express_route_circuit
6. azurerm_express_route_circuit_peering
7. azurerm_express_route_connection


~~~






1.ExpressRoute Network Gateway

2.Public IP address — associated with the ER gateway

3.ExpressRoute Circuit



1express route circuit - ciruit name - AA-express route

2 provider - 

3 peering location - drops of service provider

4 bandwidth

5 sku

6 billing model

7 subcription

8 rg

9 location - our






## ExpressRoute connectivity models

![image](https://user-images.githubusercontent.com/33985509/124996003-89da8a00-e048-11eb-832f-56d609ab0d93.png)

## Peering ExpressRoute

![image](https://user-images.githubusercontent.com/33985509/124996139-be4e4600-e048-11eb-90a0-dafc1e4d56cd.png)


## Azure Virtual WAN

![image](https://user-images.githubusercontent.com/33985509/124997897-be9c1080-e04b-11eb-8734-f356b39c5f0d.png)
