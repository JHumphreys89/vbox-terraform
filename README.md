
![X (formerly Twitter) URL](https://img.shields.io/twitter/url?url=https%3A%2F%2Ftwitter.com%2FJonHumphreys16)
![Static Badge](https://img.shields.io/badge/Version-1.0.0-purple)
![Static Badge](https://img.shields.io/badge/License-MIT-purple)

<a href="https://www.buymeacoffee.com/jhumphreys89"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-purple?&logo=buy-me-a-coffee&style=rounded&logoColor=white"></a>

| NOTICE |
|:-------|
| Terra-Farm's VirtualBox provider does not currently support Windows computers. Some people have been able to get around this, but I have not. Be warned that this will most likely ONLY work on a Linux-based OS. |

### Project status
Due to the limitations of using this provider on Windows systems, I am ending this project here. However, you can fork this repo and make changes to it how you please.

The original idea of this project was to create a virtualized environment that could be spun up and destroyed at will using VirtualBox and Terraform. This can be used as a demonstration/proof of concept or for a home lab/testing environment.

---

# VirtualBox (VBox) - Terraform
This project contains a home lab that will implement the following:
     - Contains Terraform files that create resources in VirtualBox.
     - Build and delete VMs using a CSV file.

## Installation and Running the Project
This project requires:
* A Linux machine capable of running VirtualBox
* The [VirtualBox software](https://www.virtualbox.org)
* The most recent version of [Terraform](https://developer.hashicorp.com/terraform)
* An internet connection to download the Terraform provider ([terra-farm/virtualbox](https://registry.terraform.io/providers/terra-farm/virtualbox/latest/docs))

1) Install the most recent version of VirtualBox on your preferred flavor of Linux. If using a GUI, you can download VirtualBox [here](https://www.virtualbox.org/wiki/Linux_Downloads%20).

<br>

Oracle Linux users - you can install Virtualbox through the following command using the terminal:

``` bash

yum install VirtualBox-6.1

```

2) Install Terraform through a web browser [here](https://developer.hashicorp.com/terraform/install). Oracle Linux users can install Terraform through the terminal:

``` bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

```

## VirtualBox provider used within this project. 

The provider-specific Terraform configuration for VirtualBox is simplistic in nature compared to a cloud provider. 

``` bash

terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

resource "virtualbox_vm" "node" {
  count     = 2
  name      = format("node-%02d", count.index + 1)
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 2
  memory    = "512 mib"
  user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet1"
  }
}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr_2" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
}

```

**NOTE**: The Provider page in Terraform Registry shows `version="0.2.1:` but this should be changed to `version = "0.2.2-alpha.1"` which is its most current version and will not cause Terraform to error out.

<br>

**Required Arguments**
* **name** - name of the VM
* **image** - place of the image file (in my case I am using a remote source instead of a local location.)
* **network_adapter** - network adapters for the VM (you can have up to 4.)
* **.#.type** - the type of network
     * _Allowed_ values:
          * nat
          * bridged
          * hostonly
          * internal
          * generic
* **.#.status** - status of the network adapter.
     * _Allowed_ values:
          - up
          - down


**Optional Arguments**
* **cpus** - default = 2
* **memory** - default = "512mb"
* **user_data** - default = "". This is user defined data such as for running scripts.
* **status** - default = "running". Value updated at runtime to reflect real status of VM.
     * _Allowed_ values:
          - running
          - poweroff
* **optical_disks** - The iso image to attach.

**Generated by VirtualBox**
* **.#.mac_address** - MAC address of the adapter.
* ****

## Using the Project
This project makes use of Terraform and VirtualBox in order to deploy VMs. I initially chose to make this lab using VirtualBox since the resources do not cost money in order to download, install, or use. No need for a cloud subscription or worrying about spending money just to test applying and destroying VMs using Terraform.

## A Different Dynamic (CSV Implementation)
One thing different about this setup is that it makes use of decoding CSV files to create VMs.

The **CSV location** is hardcoded through the variable `VAR_csv_file` which can be located in the `variables.tf` file for both Windows and Linux.

**Required columns**:
- vm_name - unique `name` of the VM
- cpus - any number greater than `1`
- memory - any number greater than `1`
- os - either `windows` or `linux` (not case-sensitive)

**Optional columns**:
- status - either `running` (the default) or `poweroff`

### Example CSV:

| vm_name | cpus | memory | os         |
| :-------| :----| :------| :----------|
| win_1   | 1    | 2      | windows    |
| win_2   | 1    | 2      | windows    |
| lin_1   | 1    | 2      | linux      |
| lin_2   | 1    | 2      | linux      |

# Support
For questions and support regarding VirtualBox: [_click here_](https://www.virtualbox.org/manual/). 
For questions and support regarding Terraform: [_click here_](https://developer.hashicorp.com/terraform/docs). 
To check out the Terraform Registry page for VirtualBox: [_click here_](https://registry.terraform.io/providers/terra-farm/virtualbox/latest/docs/resources/vm#url).

# License
This project is licensed under the MIT License. [Learn more](https://opensource.org/licenses/MIT)

# Buy Me a Coffee 🍵
If this helped you and you want to send me a _thanks_, you can "send me a coffee" using [this link](https://www.buymeacoffee.com/jhumphreys89). In this day and age, anything is welcome and much appreciated 😀.