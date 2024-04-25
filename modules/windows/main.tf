#MIT License

#Copyright (c) 2024 Jon Humphreys

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#This is the main.tf file for Windows machines built in VBox

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
locals {
  instances = csvdecode(file(var.VAR_csv_file))
}

####################
# VBOX VM RESOURCE #
####################

resource "virtualbox_vm" "vm" {
  for_each = { for inst in local.instances : inst.vm_name => inst if inst.os == "windows" }

  name   = each.value.vm_name
  image  = var.win_server_image
  cpus   = each.value.cpus
  memory = each.value.memory

  # Machine status can be "poweroff" or "running" (running is the default value)
  # Placed in try/catch in order to make column optional in CSV
  status = try(each.value.status != "" ? each.value.status : var.default_vm_status, var.default_vm_status)

  ## If you want to create the VM with an embedded script you can call on later   
  ## such as an initialization script
  #user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }

}

###########
# OUTPUTS #
###########

# Coming back to make this work (commenting out for now so that it doesn't fail to run)
#output "IPAddr" {
#  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
#}

#output "IPAddr_2" {
#  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
#}
