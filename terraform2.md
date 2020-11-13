

sample



mostly used 

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

![image](https://user-images.githubusercontent.com/33985509/99122828-594c6880-25ff-11eb-9984-1596b6a64bcb.png)

as we gave count =2 

![image](https://user-images.githubusercontent.com/33985509/99122933-80a33580-25ff-11eb-84d8-0101d842593e.png)


