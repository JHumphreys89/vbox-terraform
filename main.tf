terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/terraform-provider-virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

module "windows" {
    source = "./modules/windows"
}

module "linux" {
    source = "./modules/linux"
}