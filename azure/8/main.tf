resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westeurope"

  tags = {
    environment = "Staging"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = "westeurope"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = "my-resource-group"
}

resource "azurerm_subnet" "subnet" {
  name                      = "my-subnet"
  virtual_network_name      = "my-vnet"
  resource_group_name       = "my-resource-group"
  address_prefix            = "10.1.0.0/24"
}

resource "azurerm_route_table" "main" {
  name                = "my-routetable"
  location            = "westeurope"
  resource_group_name = "my-resource-group"

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "main" {
  subnet_id      = "${azurerm_subnet.main.id}"
  route_table_id = "${azurerm_route_table.main.id}"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "my-aks"
  location            = "westeurope"
  resource_group_name = "my-resource-group"

  linux_profile {
    admin_username = "admin"

    ssh_key {
      # remove any new lines using the replace interpolation function
      key_data = "${replace(var.admin_public_ssh_key, "\n", "")}"
    }
  }

  agent_pool_profile {
    name            = "nodepool"
    count           = "3"
    vm_size         = "Standard_F4
    os_type         = "Linux"
    os_disk_size_gb = 50
    # Required for advanced networking
    vnet_subnet_id = "${azurerm_subnet.main.id}"
  }
  service_principal {
    client_id     = "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_client_secret}"
  }
  network_profile {
    network_plugin = "azure"
  }
}


#### DB ####

resource "azurerm_mysql_server" "main" {
  name                = "mysql-server"
  location            = "westeurope"
  resource_group_name = "my-resource-group"

  sku {
    name     = "B_Gen5_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "admin"
  administrator_login_password = "StrongP@ssword"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_mysql_database" "main" {
  name                = "my-db"
  resource_group_name = "my-resource-group"
  server_name         = "${azurerm_mysql_server.main.name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_virtual_network_rule" "test" {
  name                = "mysql-vnet-rule"
  resource_group_name = "my-resource-group"
  server_name         = "${azurerm_mysql_server.main.name}"
  subnet_id           = "${azurerm_subnet.subnet.id}"
}

resource "azurerm_mysql_firewall_rule" "main" {
  name                = "mysql-fwrules"
  resource_group_name = "my-resource-group"
  server_name         = "${azurerm_mysql_server.main.name}"
  start_ip_address    = "10.1.0.0"
  end_ip_address      = "10.1.255.255"
}

#### ACR ####

resource "azurerm_container_registry" "main" {
  name                = "my-registry"
  resource_group_name = "my-resource-group"
  location            = "westeurope"
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_storage_account" "main" {
  name                     = "my-storage-account"
  resource_group_name      = "my-resource-group"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "main" {
  name                  = "my-container"
  resource_group_name   = "my-resource-group"
  storage_account_name  = "${azurerm_storage_account.main.name}"
  container_access_type = "container"
}

resource "azurerm_storage_blob" "mainsb" {
  name                   = "my-blob"
  resource_group_name    = "my-resource-group"
  storage_account_name   = "${azurerm_storage_account.main.name}"
  storage_container_name = "${azurerm_storage_container.main.name}"

  type = "page"
  size = 5120
}
