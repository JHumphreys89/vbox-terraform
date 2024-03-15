locals {
    instances = csvdecode(file(var.VAR_csv_file))
}

resource "virtualbox_vm" "vm" {
    for_each = { for inst in local.instances : inst.vm_name => inst if inst.os == "linux" }

    name   = each.value.vm_name
    image  = var.oracle_linux_image
    # cpus - int, default is 2
    cpus   = each.value.cpus
    # memory in MB/MiB - string - default is 512MB
    memory = each.value.memory

    #Machine status can be "poweroff" or "running" (running is the default value)
    #Placed in try/catch in order to make column optional in CSV
    status = try(each.value.status != "" ? each.value.status : var.default_vm_status, var.default_vm_status)
    
    #If you want to create the VM with an embedded script you can call on later
    #user_data = file("${path.module}/user_data")

    network_adapter {
        type           = "hostonly"
        host_interface = "vboxnet1"
    }

}

output "IPAddr" {
    value = element(virtualbox_vm.vm.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr_2" {
    value = element(virtualbox_vm.vm.*.network_adapter.0.ipv4_address 2)
}