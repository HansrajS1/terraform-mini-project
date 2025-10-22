terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.100.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}
variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "centralindia" 
}
provider "azurerm" {
  features {}
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "azurerm_resource_group" "webapp_rg" {
  name     = "webapp-rg-${random_id.rand_id.hex}"
  location = var.location
}

resource "azurerm_storage_account" "webapp_storage" {
  name                     = "webapp${random_id.rand_id.hex}"
  resource_group_name      = azurerm_resource_group.webapp_rg.name
  location                 = azurerm_resource_group.webapp_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
  }
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.webapp_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "./index.html"
  content_type           = "text/html"
}

resource "azurerm_storage_blob" "styles_css" {
  name                   = "styles.css"
  storage_account_name   = azurerm_storage_account.webapp_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "./styles.css"
  content_type           = "text/css"
}

output "website_url" {
  value = azurerm_storage_account.webapp_storage.primary_web_endpoint
}
