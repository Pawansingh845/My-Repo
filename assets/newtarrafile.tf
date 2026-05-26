terraform {
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "4.64.0"
        }
    }
}

provider "azurerm" {
    features {}

}

resource "azurerm_resource_group" "rg"{
 count = length(var.rg)
    name = var.rg[count.index]
    location = "eastus"
}

resource "azurerm_storage_account" "stg"{
    name = var.sa
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    account_tier = "Standard"
    account_replication_type = "LRS"
depends_on = [azurerm_resource_group.rg]
}
