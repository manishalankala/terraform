


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
