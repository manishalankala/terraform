

sample



| Commands  | Description |
| ------------- | ------------- |
| terraform apply | Builds or changes infrastructure |
| terraform console | Interactive console for Terraform interpolations |
| destroy | Destroy Terraform-managed infrastructure env Workspace management|
| fmt | Rewrites config files to canonical format|
| get | Download and install modules for the configuration|
| graph |Create a visual graph of Terraform resources|
| import | Import existing infrastructure into Terraform|
| init |Initialize a Terraform working directory|
| output | Read an output from a state file|
| plan | Generate and show an execution plan|
| providers | Prints a tree of the providers used in the configuration|
| refresh | Update local state file against real resources|
|show | Inspect Terraform state or plan|
| taint | Manually mark a resource for recreation|
| untaint | Manually unmark a resource as tainted|
| validate | Validates the Terraform files|
| version| Prints the Terraform version|
| workspace: Workspace management |







main.tf

```

provider "aws" {
  region = "eu-west-1"
}

resource "aws_dev_instance" "web" {
  ami     = "ami-003634241a8fcdec0"
  instance_type = "t2.micro"
  
  tags = {
      Name = "Tuts Test"
  }
  
}

```
