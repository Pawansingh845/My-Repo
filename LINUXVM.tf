terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "77be77be-d0d7-4e0b-98d0-ffeaf0bd4e5e"
}

locals {
  location = "East US"
}

resource "azurerm_resource_group" "p1" {
  name     = "TF-VM"
  location = local.location
}

resource "azurerm_virtual_network" "p2" {
  name                = "VM-Vnet"
  resource_group_name = azurerm_resource_group.p1.name
  location            = local.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "p3" {
  name                 = "VM-Subnet"
  virtual_network_name = azurerm_virtual_network.p2.name
  resource_group_name  = azurerm_resource_group.p1.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "p4" {
  name                = "Vm-publicip"
  location            = local.location
  resource_group_name = azurerm_resource_group.p1.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "p5" {
  name                = "VMNIC"
  resource_group_name = azurerm_resource_group.p1.name
  location            = local.location

  ip_configuration {
    name                          = "VMinternalip"
    subnet_id                     = azurerm_subnet.p3.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.p4.id
  }
}

resource "azurerm_linux_virtual_machine" "p6" {
  name                            = "LINUX-VM"
  location                        = local.location
  resource_group_name             = azurerm_resource_group.p1.name
  size                            = "Standard_B1s"
  admin_username                  = "pawan"
  admin_password                  = "Singh@123"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.p5.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

 source_image_reference {
  publisher = "Debian"
  offer     = "debian-11"
  sku       = "11"
  version   = "latest"
}





}
