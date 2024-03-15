terraform {
    required_providers = {
        virtualbox = {
            source = "terra-farm/virtualbox"
            version = "0.2.1"
        }
    }
}

# At this time, there are currently no configuration options for the provider itself.

module "windows" {
    source = "./modules/windows"
}

module "linux" {
    source = "./modules/linux"
}