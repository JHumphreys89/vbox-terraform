#####################
# Windows Variables #
#####################

variable "win_server_image" {
    description = "Windows Server 2019 EVAL image for Windows machines"
    # Currently on v2021.05.15
    default = "https://app.vagrantup.com/StefanScherer/boxes/windows_2019/versions/2021.05.15/providers/virtualbox/unknown/vagrant.box"
}

##############################
# Terraform & VBox Variables #
##############################

variable "default_vm_status" {
    description = "Default state of VM after creation"
    default = "running"
}

variable "VAR_csv_file" {
    description = "Location of CSV file which is hardcoded at this time"
    default = "./csv/sample.csv"
}