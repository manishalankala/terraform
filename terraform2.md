

sample

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
