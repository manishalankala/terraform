


## Scope 

Confirm what resources need to be created for a given project.

## Author 

Create the configuration file in HCL based on the scoped parameters

## Initialize 

Run terraform init in the project directory with the configuration files. 

This will download the correct provider plug-ins for the project.

## Plan & Apply 

Run terraform plan to verify creation process and then terraform apply to create real resources as well as state file that compares future changes in your configuration files to what actually exists in your deployment environment.




Meta arguments
| -------- |
| depends_on |
| count |
| for_each |
| provider |
| lifecycle |
| provisioner |
| connection |
