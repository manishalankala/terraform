####################################### Locals ####################################### 



locals {
  prefix   = "demo"
  rg_name  = "mygroup1"              #An existing Resource Group for the Application Gateway 
  sku_name = "Standard_v2"           #Sku with WAF is : WAF_v2
  sku_tier = "Standard_v2"
  zones    = ["1", "2", "3"]         #Availability zones to spread the Application Gateway over. They are also only supported for v2 SKUs.
  capacity = {
    min = 1                         #Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
    max = 3                         #Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.
  }
  subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/virtualNetworks/myvnet1/subnets/mysubnet1" #Fill Here a dedicated subnet if for the Application Gateway

  appname = "website1"
  
  backend_address_pool = {
    name  = "${local.appname}-pool1"
    fqdns = ["website1.azurewebsites.net"]
  }
  
  frontend_port_name             = "${local.appname}-feport"
  frontend_ip_configuration_name = "${local.appname}-feip"
  http_setting_name              = "${local.appname}-be-htst"
  listener_name                  = "${local.appname}-httplstn"
  request_routing_rule_name      = "${local.appname}-rqrt"
  redirect_configuration_name    = "${local.appname}-rdrcfg"

  diag_appgw_logs = [
    "ApplicationGatewayAccessLog",
    "ApplicationGatewayPerformanceLog",
    "ApplicationGatewayFirewallLog",
  ]
  diag_appgw_metrics = [
    "AllMetrics",
  ]
}

#To get the existing Application Gateway Resource Group
data "azurerm_resource_group" "rg" {
  name = local.rg_name
}
