######################
Provider
######################


provider "azurerm" {
  # Specifying the version is optional
  version = "=1.34.0"
  # Credentials are specified authenticating to Azure
  client_id = "${var.clientid}"
  client_secret = "${var.clientsecret}"
  tenant_id     = "${var.tenantid}"
  subscription_id = "${var.subscriptionid}"
}



######################
RG
######################

resource"azurerm_resource_group" "rg"{
  # Name/Location of the Resource Group in which the AKS cluster will be created.
  name  = "${var.resource_group_name}"
  location  = "${var.resource_group_location}"
}




######################
AKS
######################


resource "azurerm_kubernetes_cluster" "spoke-aks" {
  name                = "spoke1-aks"
  location            = azurerm_resource_group.spoke1-rg.location
  resource_group_name = azurerm_resource_group.spoke1-rg.name
  dns_prefix          = "${var.prefix}-aks"
  kubernetes_version = var.kube_version
  
  default_node_pool {
  name                 = "nodepool1"
  orchestrator_version = var.kube_version
  node_count           = var.node_count 
  vm_size              = var.node_size
  os_type              = "linux"
  os_disk_size_gb      = var.node_disk_size
  vnet_subnet_id       = azurerm_subnet.subnet_aks.id
  type                 = "VirtualMachineScaleSets"
  enable_auto_scaling  = false
#  availability_zones  = [1, 2, 3]
  min_count            = 1
  max_count            = 3
  max_pods             = var.node_pod_count
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  network_profile {
  load_balancer_sku = "Standard"
  network_plugin    = "kubenet" # CNI
  }
}
  
# Specifying a Service Principal for AKS Cluster
  
  service_principal {
    client_id = "${var.clientid}"
    client_secret = "${var.clientsecret}"
  }
  role_based_access_control {
    enabled = true
  }


