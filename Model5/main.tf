


############################################  Key Vault ###########################################

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "agw" {
  name                       = "${local.prefix}-hub-kv1"
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled        = true                                          #The EnableSoftDelete feature must be used for TLS termination to function properly. If you're configuring Key Vault soft-delete through the Portal, the retention period must be kept at 90 days, the default value. Application Gateway doesn't support a different retention period yet.
  soft_delete_retention_days = 90
  purge_protection_enabled   = false
  sku_name                   = "standard"

    network_acls {
      default_action = "Deny"
      bypass         = "AzureServices"
    }

  tags = data.azurerm_resource_group.rg.tags
}

resource "azurerm_key_vault_access_policy" "builder" {
  key_vault_id = azurerm_key_vault.agw.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  certificate_permissions = [
    "create",
    "get",
    "list"
  ]
}

resource "azurerm_key_vault_access_policy" "agw" {
  key_vault_id = azurerm_key_vault.agw.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.agw.principal_id

  secret_permissions = [
    "get"
  ]
}

resource "azurerm_key_vault_certificate" "website1" {
  name         = "mysite1"
  key_vault_id = azurerm_key_vault.agw.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject_alternative_names {
        dns_names = ["mysite1.com"]
      }

      subject            = "CN=website1.com"
      validity_in_months = 12
    }
  }
}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [azurerm_key_vault_certificate.website1]

  create_duration = "60s"
}














###########################################  Public IP ########################################## 


resource "azurerm_public_ip" "agw" {
  name                = "${local.prefix}-hub-agw1-pip1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = data.azurerm_resource_group.rg.tags
}






########################################## Application Gateway ########################################


resource "azurerm_application_gateway" "agw" {
  depends_on          = [azurerm_key_vault_certificate.website1, time_sleep.wait_60_seconds]
  name                = "${local.prefix}-hub-agw1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  enable_http2        = true
  zones               = local.zones
  tags                = data.azurerm_resource_group.rg.tags

  sku {
    name = local.sku_name
    tier = local.sku_tier
  }

  autoscale_configuration {
    min_capacity = local.capacity.min
    max_capacity = local.capacity.max
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.agw.id]
  }

  gateway_ip_configuration {
    name      = "${local.prefix}-hub-agw1-ip-configuration"
    subnet_id = local.subnet_id
  }

  frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}-public"
    public_ip_address_id = azurerm_public_ip.agw.id
  }

  frontend_port {
    name = "${local.frontend_port_name}-80"
    port = 80
  }

  frontend_port {
    name = "${local.frontend_port_name}-443"
    port = 443
  }

  backend_address_pool {
    name  = local.backend_address_pool.name
    fqdns = local.backend_address_pool.fqdns
  }

  ssl_certificate {
    name                = azurerm_key_vault_certificate.website1.name
    key_vault_secret_id = azurerm_key_vault_certificate.website1.secret_id
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    host_name             = local.backend_address_pool.fqdns[0]
    request_timeout       = 1
  }

  http_listener {
    name                           = "${local.listener_name}-http"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}-public"
    frontend_port_name             = "${local.frontend_port_name}-80"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "${local.listener_name}-https"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}-public"
    frontend_port_name             = "${local.frontend_port_name}-443"
    protocol                       = "Https"
    ssl_certificate_name           = azurerm_key_vault_certificate.website1.name
  }

  request_routing_rule {
    name                       = "${local.request_routing_rule_name}-https"
    rule_type                  = "Basic"
    http_listener_name         = "${local.listener_name}-https"
    backend_address_pool_name  = local.backend_address_pool.name
    backend_http_settings_name = local.http_setting_name
  }

  redirect_configuration {
    name                 = local.redirect_configuration_name
    redirect_type        = "Permanent"
    include_path         = true
    include_query_string = true
    target_listener_name = "${local.listener_name}-https"
  }

  request_routing_rule {
    name                        = "${local.request_routing_rule_name}-http"
    rule_type                   = "Basic"
    http_listener_name          = "${local.listener_name}-http"
    redirect_configuration_name = local.redirect_configuration_name
  }

  // Ignore most changes as they will be managed manually
  lifecycle {
    ignore_changes = [
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      request_routing_rule,
      url_path_map,
      ssl_certificate,
      redirect_configuration,
      autoscale_configuration
    ]
  }
}










########################################### Log Analytics Workspace ##########################################################################
# -
resource "azurerm_log_analytics_workspace" "add_log_workspace" {
  name                = "${local.prefix}-hub-logaw1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"                             #(Required) Specifies the Sku of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, and PerGB2018 (new Sku as of 2018-04-03).
  retention_in_days   = 100                                     #(Optional) The workspace data retention in days. Possible values range between 30 and 730.
  tags                = data.azurerm_resource_group.add_log_analytics.tags
}

resource "azurerm_log_analytics_solution" "add_log_analytics" {
  solution_name         = "AzureAppGatewayAnalytics"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.add_log_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.add_log_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureAppGatewayAnalytics"
  }
}


########################################### Diagnostic Settings ###########################################
## To send diagnostic settings of the Application Gateway to the Log Analytics Workspace.



resource "azurerm_monitor_diagnostic_setting" "agw" {
  name                       = "${local.prefix}-hub-agw1-diag"
  target_resource_id         = azurerm_application_gateway.agw.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.add_log_workspace.id
  dynamic "log" {
    for_each = local.diag_appgw_logs
    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = local.diag_appgw_metrics
    content {
      category = metric.value

      retention_policy {
        enabled = false
      }
    }
  }
}
