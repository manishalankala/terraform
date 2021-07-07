

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
  os_disk_size_gb      = var.node_disk_size
  max_pods             = var.node_pod_count
  vnet_subnet_id       = azurerm_subnet.subnet_aks.id
  type                 = "VirtualMachineScaleSets"
  enable_auto_scaling  = true
  min_count            = 1
  max_count            = 3
  }
  
  role_based_access_control {
    enabled = true
  }
   
