terraform {
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "tam973064815"
    container_name       = "terraformgithubexample"
    key                  = "terraformgithubexample.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.

  features {}
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = "app-service-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "myappservice-plan"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "mywebapp22453627"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  #(Optional)
  site_config {
dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
  
  #(Optional)
  app_settings = {
    "SOME_KEY" = "some-value"
  }

}



