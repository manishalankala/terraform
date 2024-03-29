



terraform init

terraform plan

terraform apply

terraform destroy




| Commands  | Description |
| ------------- | ------------- |
| terraform apply | Builds or changes infrastructure |
| terraform console | Interactive console for Terraform interpolations |
| terraform destroy | Destroy Terraform-managed infrastructure env Workspace management|
| terraform fmt | Rewrites config files to canonical format|
| terraform get | Download and install modules for the configuration|
| terraform graph |Create a visual graph of Terraform resources|
| terraform import | Import existing infrastructure into Terraform|
| terraform init |Initialize a Terraform working directory|
| terraform output | Read an output from a state file|
| terraform plan | Generate and show an execution plan|
| terraform providers | Prints a tree of the providers used in the configuration|
| terraform refresh | Update local state file against real resources|
| terraform show | Inspect Terraform state or plan|
| terraform taint | Manually mark a resource for recreation|
| terraform untaint | Manually unmark a resource as tainted|
| terraform validate | Validates the Terraform files|
| terraform version| Prints the Terraform version|
| terraform workspace | Workspace management |


Configuration blocks
| ------------- |
| Resources |
| Provider Requirements |
| Provider configuration |
| Input Variables |
| Output Values |
| Local Values |
| Modules |
| Data Sources  |
| Backend Configuration |
| Terraform Settings |
| Provisioners |







Resource

<RESOURCE TYPE>.<NAME>.<ATTRIBUTE>

Providers


The depends_on argument should be used only as a last resort

```

depends_on = [
    aws_iam_role_policy.example,
  ]
}


```
## Resource Arguments

Types and Values : string,number,bool,list,map


count or for_each

alias

lifecycle

```
lifecycle {
    create_before_destroy = true
  }
}


```


create_before_destroy 

prevent_destroy

ignore_changes


provisioner and connection




Input Variables


Identifiers can contain letters, digits, underscores (_), and hyphens (-). The first character of an identifier must not be a digit, to avoid ambiguity with literal numbers.



The name of a variable can be any valid identifier except the following: - source,version,providers,count,for_each,lifecycle,depends_on,locals


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
