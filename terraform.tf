terraform {
  required_version = "~> 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.13"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.3.0"
    }
  }
  backend "azurerm" {}
}

provider "azapi" {
  skip_provider_registration = true
  subscription_id            = var.subscription_id_management
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  alias                      = "management"
  subscription_id            = var.subscription_id_management
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  alias                      = "connectivity"
  subscription_id            = var.subscription_id_connectivity
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "github" {
  owner = "frasermolyneux-poc"
}
