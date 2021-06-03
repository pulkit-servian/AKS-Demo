#This defines the backend of terraform for storing its state files
terraform {
  backend "azurerm" {
    resource_group_name  = "aks-demo"
    storage_account_name = "aksdemoterraform"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
