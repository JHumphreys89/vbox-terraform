terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
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