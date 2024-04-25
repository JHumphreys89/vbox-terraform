#MIT License

#Copyright (c) 2024 Jon Humphreys

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#############
# PROVIDERS #
#############

terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

###########
# MODULES #
###########

module "windows" {
  source = "./modules/windows"
}

module "linux" {
  source = "./modules/linux"
}
