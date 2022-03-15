storage_accounts = {
  diagnostics = {
    name               = "shared-dev-001"
    resource_group_key = "rg_core"
    account_kind       = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    tags = {
      environment = "test"
      team        = "IT"
    }
    delete_retention_policy = {
      days = "15"
    }
    containers = {
      container = {
        name = "diagnostics"
      }
    }
    network_rules = {
      default_action = "Allow"
      bypass         = "Logging"
      vnet_key       = "vnet_core"
      subnet_key     = ""
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
