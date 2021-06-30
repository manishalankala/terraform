provider "azurerm" {
    subscription_id        = "${var.azure_subscription_id}"
    client_id              = "${var.azure_client_id}"
    client_secret          = "${var.azure_client_secret}"
    tenant_id              = "${var.azure_tenant_id}"
    version                = "~> 2.15" 
    #storage_use_azuread   = true
    
      features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }            
}


  
  



