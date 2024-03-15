###################
# Linux Variables #
###################

variable "oracle_linux_image" {
    description = "Oracle Linux 9 image for Linux machines"
    # Currently on v4.3.12
    default = "https://app.vagrantup.com/generic/boxes/oracle9/versions/4.3.12/providers/virtualbox/amd64/vagrant.box"
}

##############################
# Terraform & VBox Variables #
##############################

variable "default_vm_status" {
    description = "Default state of VM after creation"
    default = "running"
}