# Create virtual network
# The resource names in the module get prefixed by module.<module-instance-name> when instantiated
resource "azurerm_virtual_network" "terraformnetwork" {
    name                = "devVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    tags {
        environment = "DEV"
    }
}

# Create subnet
resource "azurerm_subnet" "terraformsubnet" {
    name                 = "devSubnet"
    resource_group_name  = "${var.resource_group_name}"
    virtual_network_name = "${azurerm_virtual_network.terraformnetwork.name}"
    address_prefix       = "10.0.1.0/24"
}

# Create public IPs
resource "azurerm_public_ip" "terraformpublicip" {
    name                         = "devPublicIP"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    public_ip_address_allocation = "dynamic"

    tags {
        environment = "DEV"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "terraformnsg" {
    name                = "devNetworkSecurityGroup"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags {
        environment = "DEV"
    }
}

# Create network interface
resource "azurerm_network_interface" "terraformnic" {
    name                              = "devNIC"
    location                          = "${var.location}"
    resource_group_name               = "${var.resource_group_name}"
    network_security_group_id         = "${azurerm_network_security_group.terraformnsg.id}"
    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "${azurerm_subnet.terraformsubnet.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.terraformpublicip.id}"
    }

    tags {
        environment = "DEV"
    }
}

