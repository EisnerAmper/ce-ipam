# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

locals {
    app_name    = "ipam"
    app_id      = "827928ce-dcf1-4442-9394-8f4bf52cb56c"
    business_owner = "GPS"
    classification = "1"
    description = "IP Address Management Platform"
    technical_owner = "Cloud Engineering"
    environment = "dev"
    team        = "cloud engineering"
    retention_in_days = "90"
}

import {
	id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk"
	to = azurerm_resource_group.ipam_resource_group
}

# __generated__ by Terraform from "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk"
resource "azurerm_resource_group" "ipam_resource_group" {
  location = "eastus2"
  name     = "${local.app_name}${local.environment}-rg-obf56ae2gqywk"
  tags = {
    app_name    = "${local.app_name}"
    app_id      = "${local.app_id}"
    business_owner = "${local.business_owner}"
    classification = "${local.classification}"
    description = "${local.description}"
    technical_owner = "${local.technical_owner}"
    environment = "${local.environment}"
    team        = "${local.team}"
  }
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
  id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ipamdev-mi-obf56ae2gqywk"
  to = azurerm_user_assigned_identity.ipam_engine_managed_identity
}

# __generated__ by Terraform from "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ipamdev-mi-obf56ae2gqywk"
resource "azurerm_user_assigned_identity" "ipam_engine_managed_identity" {
  location            = "${azurerm_resource_group.ipam_resource_group.location}"
  name                = "${local.app_name}${local.environment}-mi-obf56ae2gqywk"
  resource_group_name = "${azurerm_resource_group.ipam_resource_group.name}"
  tags                = azurerm_resource_group.ipam_resource_group.tags
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
	id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.Web/serverfarms/ipamdev-asp-obf56ae2gqywk"
	to = azurerm_service_plan.ipam_service_plan
}

# __generated__ by Terraform from "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.Web/serverfarms/ipamdev-asp-obf56ae2gqywk"
resource "azurerm_service_plan" "ipam_service_plan" {
  app_service_environment_id   = null
  location                     = "${azurerm_resource_group.ipam_resource_group.location}"
  maximum_elastic_worker_count = 1
  name                         = "${local.app_name}${local.environment}-asp-obf56ae2gqywk"
  os_type                      = "Linux"
  per_site_scaling_enabled     = false
  resource_group_name          = "${azurerm_resource_group.ipam_resource_group.name}"
  sku_name                     = "EP1"
  tags                         = azurerm_resource_group.ipam_resource_group.tags
  worker_count                 = 1
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
  id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.ContainerRegistry/registries/ipamdevacrobf56ae2gqywk"
  to = azurerm_container_registry.ipam_container_registry
}

# __generated__ by Terraform
resource "azurerm_container_registry" "ipam_container_registry" {
  admin_enabled          = false
  anonymous_pull_enabled = false
  data_endpoint_enabled  = false
  /*
  encryption = [{
    enabled            = false
    identity_client_id = ""
    key_vault_key_id   = ""
  }]
  */
  export_policy_enabled         = true
  location                      = "${azurerm_resource_group.ipam_resource_group.location}"
  name                          = "${local.app_name}${local.environment}acrobf56ae2gqywk"
  network_rule_bypass_option    = "AzureServices"
  network_rule_set              = []
  public_network_access_enabled = true
  quarantine_policy_enabled     = false
  resource_group_name           = "${azurerm_resource_group.ipam_resource_group.name}"
  retention_policy = [{
    days    = 7
    enabled = false
  }]
  sku  = "Standard"
  tags = azurerm_resource_group.ipam_resource_group.tags
  trust_policy = [{
    enabled = false
  }]
  zone_redundancy_enabled = false
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
  id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.OperationalInsights/workspaces/ipamdev-law-obf56ae2gqywk"
  to = azurerm_log_analytics_workspace.ipam_log_analytics
}

# __generated__ by Terraform from "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.OperationalInsights/workspaces/ipamdev-law-obf56ae2gqywk"
resource "azurerm_log_analytics_workspace" "ipam_log_analytics" {
  daily_quota_gb                     = -1
  internet_ingestion_enabled         = true
  internet_query_enabled             = true
  location                           = "${azurerm_resource_group.ipam_resource_group.location}"
  name                               = "${local.app_name}${local.environment}-law-obf56ae2gqywk"
  reservation_capacity_in_gb_per_day = null
  resource_group_name                = "${azurerm_resource_group.ipam_resource_group.name}"
  retention_in_days                  = 30
  sku                                = "PerGB2018"
  tags                               = azurerm_resource_group.ipam_resource_group.tags
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
  id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.Storage/storageAccounts/ipamdevstgobf56ae2gqywk"
  to = azurerm_storage_account.ipam_storage_account
}

# __generated__ by Terraform
resource "azurerm_storage_account" "ipam_storage_account" {
  access_tier                       = "Hot"
  account_kind                      = "StorageV2"
  account_replication_type          = "LRS"
  account_tier                      = "Standard"
  allow_nested_items_to_be_public   = false
  edge_zone                         = null
  enable_https_traffic_only         = true
  infrastructure_encryption_enabled = false
  is_hns_enabled                    = false
  large_file_share_enabled          = null
  location                          = "${azurerm_resource_group.ipam_resource_group.location}"
  min_tls_version                   = "TLS1_0"
  name                              = "${local.app_name}${local.environment}stgobf56ae2gqywk"
  nfsv3_enabled                     = false
  queue_encryption_key_type         = "Service"
  resource_group_name               = "${azurerm_resource_group.ipam_resource_group.name}"
  shared_access_key_enabled         = true
  table_encryption_key_type         = "Service"
  tags                              = azurerm_resource_group.ipam_resource_group.tags
  blob_properties {
    change_feed_enabled      = false
    default_service_version  = null
    last_access_time_enabled = false
    versioning_enabled       = false
  }
  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
  queue_properties {
    hour_metrics {
      enabled               = true
      include_apis          = true
      retention_policy_days = 7
      version               = jsonencode(1.1)
    }
    logging {
      delete                = false
      read                  = false
      retention_policy_days = 90
      version               = jsonencode(1.1)
      write                 = false
    }
    minute_metrics {
      enabled               = false
      include_apis          = false
      retention_policy_days = 30
      version               = jsonencode(1.1)
    }
  }
  share_properties {
    retention_policy {
      days = 7
    }
  }
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
	id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.DocumentDB/databaseAccounts/ipamdev-dbacct-obf56ae2gqywk"
  to = azurerm_cosmosdb_account.ipam_cosmos_db_account
}

# __generated__ by Terraform from "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.DocumentDB/databaseAccounts/ipamdev-dbacct-obf56ae2gqywk"
resource "azurerm_cosmosdb_account" "ipam_cosmos_db_account" {
  access_key_metadata_writes_enabled    = false
  analytical_storage_enabled            = false
  create_mode                           = null
  default_identity_type                 = "FirstPartyIdentity"
  enable_automatic_failover             = true
  enable_free_tier                      = false
  enable_multiple_write_locations       = false
  ip_range_filter                       = null
  is_virtual_network_filter_enabled     = false
  key_vault_key_id                      = null
  kind                                  = "GlobalDocumentDB"
  local_authentication_disabled         = false
  location                              = "${azurerm_resource_group.ipam_resource_group.location}"
  mongo_server_version                  = null
  name                                  = "${local.app_name}${local.environment}-dbacct-obf56ae2gqywk"
  network_acl_bypass_for_azure_services = false
  network_acl_bypass_ids                = []
  offer_type                            = "Standard"
  public_network_access_enabled         = true
  resource_group_name                   = "${azurerm_resource_group.ipam_resource_group.name}"
  tags                                  = azurerm_resource_group.ipam_resource_group.tags
  analytical_storage {
    schema_type = "WellDefined"
  }
  backup {
    interval_in_minutes = 240
    retention_in_hours  = 8
    storage_redundancy  = "Geo"
    type                = "Periodic"
  }
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }
  geo_location {
    failover_priority = 0
    location          = "eastus2"
    zone_redundant    = false
  }
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
  id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.Web/sites/ipamdev-obf56ae2gqywk"
  to = azurerm_linux_function_app.ipam_engine_function_app
}

# __generated__ by Terraform
resource "azurerm_linux_function_app" "ipam_engine_function_app" {
  app_settings = {
    AZURE_ENV                           = "AZURE_PUBLIC"
    CONTAINER_NAME                      = "${local.app_name}${local.environment}-ctr"
    COSMOS_URL                          = "https://${local.app_name}${local.environment}-dbacct-obf56ae2gqywk.documents.azure.com:443/"
    DATABASE_NAME                       = "${local.app_name}${local.environment}-db"
    ENGINE_APP_ID                       = "@Microsoft.KeyVault(SecretUri=https://${local.app_name}${local.environment}-kv-obf56ae2gqywk.vault.azure.net/secrets/ENGINE-ID/)"
    ENGINE_APP_SECRET                   = "@Microsoft.KeyVault(SecretUri=https://${local.app_name}${local.environment}-kv-obf56ae2gqywk.vault.azure.net/secrets/ENGINE-SECRET/)"
    KEYVAULT_URL                        = "https://${local.app_name}${local.environment}-kv-obf56ae2gqywk.vault.azure.net/"
    MANAGED_IDENTITY_ID                 = "@Microsoft.KeyVault(SecretUri=https://${local.app_name}${local.environment}-kv-obf56ae2gqywk.vault.azure.net/secrets/IDENTITY-ID/)"
    TENANT_ID                           = "@Microsoft.KeyVault(SecretUri=https://${local.app_name}${local.environment}-kv-obf56ae2gqywk.vault.azure.net/secrets/TENANT-ID/)"
    UI_APP_ID                           = "@Microsoft.KeyVault(SecretUri=https://${local.app_name}${local.environment}-kv-obf56ae2gqywk.vault.azure.net/secrets/UI-ID/)"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
  builtin_logging_enabled         = false
  client_certificate_enabled      = false
  client_certificate_mode         = "Required"
  content_share_force_disabled    = false
  daily_memory_time_quota         = 0
  enabled                         = true
  functions_extension_version     = "~4"
  https_only                      = true
  #key_vault_reference_identity_id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ipamdev-mi-obf56ae2gqywk"
  key_vault_reference_identity_id = "${azurerm_user_assigned_identity.ipam_engine_managed_identity.id}"
  location                        = "${azurerm_resource_group.ipam_resource_group.location}"
  name                            = "${local.app_name}${local.environment}-obf56ae2gqywk"
  resource_group_name             = "${azurerm_resource_group.ipam_resource_group.name}"
  service_plan_id                 = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.Web/serverfarms/ipamdev-asp-obf56ae2gqywk"
  storage_account_access_key      = "${azurerm_storage_account.ipam_storage_account.primary_access_key}" # sensitive
  storage_account_name            = "${azurerm_storage_account.ipam_storage_account.name}"
  storage_key_vault_secret_id     = null
  #storage_uses_managed_identity   = false
  tags                            = {
    "hidden-link: /app-insights-conn-string" = "InstrumentationKey=c27c7647-a875-4ca6-9d0a-ff8e948d43ae;IngestionEndpoint=https://eastus2-3.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus2.livediagnostics.monitor.azure.com/;ApplicationId=c4a37fd3-371f-47f7-93b6-615beb122dd1"
    "hidden-link: /app-insights-instrumentation-key" = "c27c7647-a875-4ca6-9d0a-ff8e948d43ae"
    "hidden-link: /app-insights-resource-id" = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/microsoft.insights/components/ipamdev-obf56ae2gqywk"
  }
  auth_settings {
    additional_login_parameters    = {}
    allowed_external_redirect_urls = []
    default_provider               = null
    enabled                        = false
    issuer                         = null
    runtime_version                = null
    token_refresh_extension_hours  = 0
    token_store_enabled            = false
    unauthenticated_client_action  = null
  }
  identity {
    identity_ids = ["${azurerm_user_assigned_identity.ipam_engine_managed_identity.id}"]
    type         = "UserAssigned"
  }
  site_config {
    always_on                                     = false
    api_definition_url                            = null
    api_management_api_id                         = null
    app_command_line                              = null
    app_scale_limit                               = 0
    application_insights_connection_string        = "${azurerm_application_insights.ipam_application_insights.connection_string}" # sensitive
    application_insights_key                      = "${azurerm_application_insights.ipam_application_insights.instrumentation_key}" # sensitive
    container_registry_managed_identity_client_id = "ff5f78af-38e4-4963-8651-3e5ab36ec4ea"
    container_registry_use_managed_identity       = true
    default_documents                             = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php"]
    elastic_instance_minimum                      = 1
    ftps_state                                    = "FtpsOnly"
    health_check_eviction_time_in_min             = 2
    health_check_path                             = "/api/status"
    http2_enabled                                 = false
    ip_restriction                                = []
    load_balancing_mode                           = "LeastRequests"
    managed_pipeline_mode                         = "Integrated"
    minimum_tls_version                           = jsonencode(1.2)
    pre_warmed_instance_count                     = 1
    remote_debugging_enabled                      = false
    remote_debugging_version                      = null
    runtime_scale_monitoring_enabled              = false
    scm_ip_restriction                            = []
    scm_minimum_tls_version                       = jsonencode(1.2)
    scm_use_main_ip_restriction                   = false
    use_32_bit_worker                             = false
    vnet_route_all_enabled                        = false
    websockets_enabled                            = false
    worker_count                                  = 1
    app_service_logs {
      disk_quota_mb         = 50
      retention_period_days = 7
    }
    application_stack {
      //dotnet_version              = null
      //java_version                = null
      //node_version                = null
      //powershell_core_version     = null
      //python_version              = null
      //use_custom_runtime          = true
      //use_dotnet_isolated_runtime = false
      docker {
        image_name        = "ipamdevacrobf56ae2gqywk.azurecr.io/ipamfunc"
        image_tag         = "latest"
        registry_password = null # sensitive
        registry_url      = "https://ipamdevacrobf56ae2gqywk.azurecr.io"
        registry_username = null # sensitive
      }
    }
  }
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

import {
  id = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/microsoft.insights/components/ipamdev-obf56ae2gqywk"
  to = azurerm_application_insights.ipam_application_insights
}

# __generated__ by Terraform from "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/microsoft.insights/components/ipamdev-obf56ae2gqywk"
resource "azurerm_application_insights" "ipam_application_insights" {
  application_type                      = "web"
  daily_data_cap_in_gb                  = 100
  daily_data_cap_notifications_disabled = false
  disable_ip_masking                    = false
  force_customer_storage_for_profiler   = false
  internet_ingestion_enabled            = true
  internet_query_enabled                = true
  local_authentication_disabled         = false
  location                              = "${azurerm_resource_group.ipam_resource_group.location}"
  name                                  = "${local.app_name}${local.environment}-obf56ae2gqywk"
  resource_group_name                   = "${azurerm_resource_group.ipam_resource_group.name}"
  retention_in_days                     = 90
  sampling_percentage                   = 0
  tags                                  = azurerm_resource_group.ipam_resource_group.tags
  workspace_id                          = "/subscriptions/70e512a1-e3fa-4f34-a787-27217f8b5a87/resourceGroups/ipamdev-rg-obf56ae2gqywk/providers/Microsoft.OperationalInsights/workspaces/ipamdev-law-obf56ae2gqywk"
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}
