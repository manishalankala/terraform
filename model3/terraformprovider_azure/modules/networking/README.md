This module handles the following types of subnet creation:

## Subnets:

add, change, or delete of subnet supported. The subnet name and address range must be unique within the address space for the virtual network. A subnet may optionally have one or more service endpoints enabled for it. To enable a service endpoint for a service, select the service or services that you want to enable service endpoints for from the Services list. 
A subnet may optionally have one or more delegations enabled for it. Subnet delegation gives explicit permissions to the service to create service-specific resources in the subnet using a unique identifier during service deployment. To delegate for a service, select the service you want to delegate to from the Services list.

## GatewaySubnet:

Subnet to provision VPN Gateway or Express route Gateway. 
This can be created by setting up gateway_subnet_address_prefix argument with a valid address prefix. This subnet must have a name "AzureFirewallSubnet" and the mask of at least /27

## AzureFirewallSubnet:

If added the Firewall module, this subnet is to deploys an Azure Firewall that will monitor all incoming and outgoing traffic. This can be created by setting up firewall_subnet_address_prefix argument with a valid address prefix. This subnet must have a name "AzureFirewallSubnet" and the mask of at least /26 It is also possible to add other routes to the associated route tables outside of this module. This module also creates network security groups for all subnets except Gateway and firewall subnets.
