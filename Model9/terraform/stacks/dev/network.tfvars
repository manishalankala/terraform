## Networking configuration
networking = {
  vnet_core = {
    resource_group_key = "rg_core"
    location           = "north"
    vnet = {
      name          = "shared-dev-001"
      address_space = ["0.0.0.0/21"]
      dns_servers   = ["8.8.8.8", "1.1.1.1"]
    }
    
    specialsubnets = {}
    subnets = {
      application = {
        name                                           = "app-dev-001"
        cidr                                           = ["10.24.2.0/23"]
        nsg_name                                       = "app-dev-001"
        nsg                                            = "appnsg"
        route_table_key                                = "approutetable"
        enforce_private_link_endpoint_network_policies = "true"
        enforce_private_link_service_network_policies  = "true"
        service_endpoints = [
          "Microsoft.AzureCosmosDB",
          "Microsoft.EventHub",
          "Microsoft.KeyVault"
        ]
      }
      data = {
        name                                           = "data-dev-001"
        cidr                                           = ["10.24.0.128/25"]
        nsg_key                                        = "datansg"
        route_table_key                                = "dataroutetable"
        enforce_private_link_endpoint_network_policies = "true"
        enforce_private_link_service_network_policies  = "true"
        service_endpoints = [
          "Microsoft.AzureCosmosDB",
          "Microsoft.EventHub",
          "Microsoft.KeyVault",
          "Microsoft.Sql"
        ]
      }
      
      # devopsagent = {         ### Not needed
      #   name     = "nb-devopsagent-dev"
      #   cidr     = ["10.24.1.0/26"]
      #   nsg_name = "nb-devopsagent-dev-uaen"
      #   nsg      = []
      #   route_table_key = "devopsagentroutetable"
      #   service_endpoints = [
      #     "Microsoft.AzureCosmosDB",
      #     "Microsoft.EventHub"
      #   ]
      # }
      
    }
    diags = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, true, 15],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 15],
      ]
    }

    tags = {
      application         = "infra"
      environment         = "dev"
      product             = "shared"
      data-classification = "internal"
      contact             = "abc@mail.com"
    }
  }
}

route_tables = {
  approutetable = {
    name                          = "app-dev-001"
    resource_group_key            = "rg_core"
    location                      = " "
    disable_bgp_route_propagation = false
  }
  dataroutetable = {
    name                          = "nb-data-dev"
    resource_group_key            = "rg_core"
    location                      = " "
    disable_bgp_route_propagation = false
  }
  
  # devopsagentroutetable = {
  #   name = "nb-devopsagent-dev"
  #   resource_group_key      = "rg_core"
  #   location = "north"
  #   disable_bgp_route_propagation = false
  # }
  
  
}

azurerm_routes = {
  app_egress_route = {
    name                      = "app-dev-001"
    resource_group_key        = "rg_core"
    route_table_key           = "approutetable"
    address_prefix            = "0.0.0.0/0"
    next_hop_type             = "virtualappliance"
    azurerm_firewall_key      = "firewall1"
    next_hop_in_ip_address    = "10.20.0.68"
    next_hop_in_ip_address_fw = "10.20.0.68"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  data_egress_route = {
    name                      = "nb-data-dev"
    resource_group_key        = "rg_core"
    route_table_key           = "dataroutetable"
    address_prefix            = "0.0.0.0/0"
    next_hop_type             = "virtualappliance"
    azurerm_firewall_key      = "firewall1"
    next_hop_in_ip_address    = "10.20.0.68"
    next_hop_in_ip_address_fw = "10.20.0.68"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  data_egress_HDI1 = {
    name               = "nb-data-HD1-dev-uaen"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  data_egress_HDI2 = {
    name               = "nb-data-HD2-dev"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  data_egress_HDI3 = {
    name               = "nb-data-HD3-dev"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  data_egress_HDI4 = {
    name               = "nb-data-HD4-dev"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  data_egress_HDI5 = {
    name               = "nb-data-HD5-dev"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  data_egress_HDI6 = {
    name               = "nb-data-HD6-dev"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  data_egress_HDI7 = {
    name               = "nb-data-HD7-dev-uaen"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
  }
  data_egress_HDI8 = {
    name               = "nb-data-HD8-dev"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
  }
  data_egress_pubfw = {
    name               = "nb-data-pubfw-dev"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "Internet"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  # devops_egress_route = {
  #   name                      = "nb-devops-dev-uaen"
  #   resource_group_key        = "rg_core"
  #   route_table_key           = "devopsagentroutetable"
  #   address_prefix            = "0.0.0.0/0"
  #   next_hop_type             = "virtualappliance"
  #   azurerm_firewall_key      = "firewall1"
  #   next_hop_in_ip_address    = "10.20.0.68"
  #   next_hop_in_ip_address_fw = "10.20.0.68"
  #   #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  #}
  
  vnet_egressapp_route = {
    name               = "nb-vnetapp-dev-uaen"
    resource_group_key = "rg_core"
    route_table_key    = "approutetable"
    address_prefix     = " "
    next_hop_type      = "VnetLocal"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  vnet_egressdata_route = {
    name               = "nb-vnetdata-dev-uaen"
    resource_group_key = "rg_core"
    route_table_key    = "dataroutetable"
    address_prefix     = " "
    next_hop_type      = "VnetLocal"
    #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  }
  
  # vnet_egressdevops_route = {
  #   name                      = "nb-vnetdevops-dev"
  #   resource_group_key        = "rg_core"
  #   route_table_key           = "devopsagentroutetable"
  #   address_prefix            = " "
  #   next_hop_type             = "VnetLocal"
  #   #try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(try(local.combined_objects_azurerm_firewalls[local.client_config.landingzone_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, local.combined_objects_azurerm_firewalls[each.value.lz_key][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address), null) : null
  #}
}

public_ip_addresses = {
}

#
# Definition of the networking security groups
#
network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {
  }

  datansg = {
    name = "nsg-nb-data-uaen-001"
    nsg = [
      {
        name                       = "hdirule1"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefixes    = [" "]
        destination_address_prefix = "VirtualNetwork"
        description                = "HDI health and management address  for North"
      },
      {
        name                       = "hdirule2"
        priority                   = 301
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefixes    = [" "]
        destination_address_prefix = "VirtualNetwork"
        description                = "HDI health and management address for  North"
      },
      {
        name                       = "hdirule3"
        priority                   = 302
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefixes    = [" "]
        destination_address_prefix = "VirtualNetwork"
        description                = "HDI health and management address "
      },
      {
        name                       = "hdirule4"
        priority                   = 303
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefixes    = [" "]
        destination_address_prefix = "VirtualNetwork"
        description                = "HDI health and management address "
      },
      {
        name                       = "hdirule5"
        priority                   = 304
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefixes    = [" "]
        destination_address_prefix = "VirtualNetwork"
        description                = "HDI health and management address  "
      },
      {
        name                       = "hdirule6"
        priority                   = 305
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefixes    = [" "]
        destination_address_prefix = "VirtualNetwork"
        description                = "HDI health and management address "
      },
      # {
      #   name                       = "hdirule7"
      #   priority                   = 306
      #   direction                  = "Inbound"
      #   access                     = "Allow"
      #   protocol                   = "*"
      #   source_port_range          = "*"
      #   destination_port_range     = "22"
      #   source_address_prefixes    = [" ", " ", " "]
      #   destination_address_prefix = "VirtualNetwork"
      #   description                = "SSH Allow on port 22"
      #   service                    = "SSH"
      # },
      {
        name                       = "hdirule8" ## Required for HDI deployment
        priority                   = 307
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "9400"
        source_address_prefixes    = [" ", " "]
        destination_address_prefix = "VirtualNetwork"
        description                = "Allowing Kafka REST proxy"
      }
    ]
  }

  appnsg = {
    name = "nsg-app-001"
    nsg = [
    ]
  }

}
