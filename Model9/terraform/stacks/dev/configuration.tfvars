global_settings = {
  default_region = "region1"
  regions = {
    region1 = " "
  }
  env           = "dev"
  location      = " "
  random_length = 0
  prefix        = ""
  alhpa         = ""
  tags = {
    application         = "infra"
    environment         = "test"
    product             = "shared"
    data-classification = "internal"
    contact             = "abc@mail.com"
  }
}

resource_groups = {
  rg_core = {
    name      = "rg-core-001"
    location  = " "
    useprefix = false
    tags = {
      environment = "dev"
      team        = "IT"
    }
  }
}
