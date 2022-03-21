












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

```

output "instance" {
	value = aws_instance.web[0].public_ip
}

```


or for all instances 

```

output "instance" {
	value = aws_instance.web[*].public_ip
}

```

terraform apply -auto-approve



![image](https://user-images.githubusercontent.com/33985509/99123785-2e631400-2601-11eb-8044-7caddaa64274.png)

lifecycle {
	create_before_destroy = true
	prevent_destroy = true
	ignore_changes = [tags]
}


![image](https://user-images.githubusercontent.com/33985509/99131363-3a57d180-2613-11eb-9b52-b55867aa9b99.png)


![image](https://user-images.githubusercontent.com/33985509/99132122-712ee700-2615-11eb-9d37-6de81b140234.png)

terraform apply -var-file dev.tfvars
terraform apply -var-file prod.tfvars
