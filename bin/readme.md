# VirtualBox Terraform Environment

The bin directory holds various scripts used within the Terraform directory including the deployment shell script which kicks off the Terraform plan and apply stages

### Environment Variables

The following environment variables are used within this VirtualBox Terraform environment:

| Environment Variable | Description                                                                       |
|:---------------------|:----------------------------------------------------------------------------------|
|TERRAFORM_DIRECTORY   | Location of the Terraform Directory                                               |
|VAR_csv_file          | Location of the CSV file                                                          |

## deployment.sh

This script kicks off the Terraform plan and apply stages and calls on scripts to check for duplicate hostnames within the VirtualBox environment and makes sure there are no invalid characters or whitespaces within the contents of the CSV file

### Required CSV fields

The following CSV fields are needed in order for the VirtualBox image to work

\| vm_name \| cpus \| memory \| os \|

## dup_hostname_check.py

## Additional Notes