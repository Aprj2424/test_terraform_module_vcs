terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.1"
    }
  }

backend "azurerm" {
    resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "tfstorageacct03891"
    container_name       = "tfstate"  # need to allow anonymous on config
    key                  = "demo.terraform.tfstate"

    use_azuread_auth     = true
    use_cli              = true
  }

}

provider "azurerm" {
  features {

  }
  subscription_id = "2bc25288-1960-4b67-8772-74f5324c3613"
}

module "demo_vm" {
  source   = "git::https://apr-ado-organization@dev.azure.com/apr-ado-organization/shared-module/_git/shared-module"
 "demo_vm_rg"
  location = "eastus"
  vnet_configs = {
    vnet_name        = "vm_vnet"
    vnet_add_space   = ["10.0.0.0/16"]
    subnet_name      = "vm_subnet"
    subnet_add_space = ["10.0.2.0/24"]



  }

  # this is config for VM
  cfg = {
    vmname               = "demo_virtualmachine"
    vmsize               = "Standard_B2s"
    admin_username       = "iamadmin01"
    admin_password       = "Password123!"
    storage_account_type = "Standard_LRS"
    publisher            = "MicrosoftWindowsServer"
    offer                = "WindowsServer"
    sku                  = "2016-Datacenter"
    version              = "latest"
  }




}


/*
Have 409 conflict but this code is good

*/
*/
