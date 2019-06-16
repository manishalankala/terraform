# Terraform



![image](https://user-images.githubusercontent.com/33985509/59514648-94ec7b80-8ebd-11e9-928b-40d18609a767.png)


. Aws account 

. Aws roles 

. Terraform




## Creating AWS account

https://aws.amazon.com/console/


Create your account

Go to the Amazon Web Services home page.

Choose Sign Up.

Note: If you've signed in to AWS recently, the button might say Sign In to the Console.


Enter your account information, and then choose Continue.

Important: Be sure that you enter your account information correctly, especially your email address. 

If you enter your email address incorrectly, you won't be able to access your account. 

If Create a new AWS account isn't visible, first choose Sign in to a different account, and then choose Create a new AWS account.

Choose Personal or Professional.

Note: Personal accounts and professional accounts have the same features and functions.

Enter your company or personal information.

Read and accept the AWS Customer Agreement.

Note: Be sure that you read and understand the terms of the AWS Customer Agreement.

Choose Create Account and Continue.

You receive an email to confirm that your account is created. 

You can sign in to your new account using the email address and password you supplied. 

However, you can't use AWS services until you finish activating your account.

Add a payment method

On the Payment Information page, enter the information about your payment method, and then choose Secure Submit.

Note: If you want to use a different address for your AWS account, choose Use a new address before you choose Secure Submit.

Verify your phone number

Choose whether you want to verify your account by Text message (SMS) or a Voice call.

Choose your country or region code from the list.

Enter a phone number where you can be reached in the next few minutes.

Enter the code displayed in the captcha.

When you're ready, choose Contact me. In a few moments, an automated system will contact you.

Note: If you chose to verify your account by SMS, choose Send SMS instead.

Enter the PIN you receive by text message or voice call, and then choose Continue.

Choose an AWS Support plan

On the Select a Support Plan page, choose one of the available Support plans. 

For a description of the available Support plans and their benefits, see Compare AWS Support Plans.

Wait for account activation

After you choose a Support plan, a confirmation page indicates that your account is being activated.

Accounts are usually activated within a few minutes, but the process might take up to 24 hours.

You can sign in to your AWS account during this time. The AWS home page might display a button that shows "Complete Sign Up" during this time, 

even if you've completed all the steps in the sign-up process.

When your account is fully activated, you'll receive a confirmation email.

After you receive this email, you have full access to all AWS services.

Troubleshooting delays in account activation

Account activation can sometimes be delayed. 

If the process takes more than 24 hours, check the following:

Finish the account activation process. You might have accidentally closed the window for the sign-up process before you've added all the necessary information. 

To finish the sign-up process, 

open https://aws-portal.amazon.com/gp/aws/developer/registration/index.html 


sign in using the email address and password you chose for the account.


Check the information associated with your payment method.

Check Payment Methods in the AWS Billing and Cost Management console. 

Fix any errors in the information.

Contact your financial institution. 

Financial institutions occasionally reject authorization requests from AWS for various reasons. 

Contact your payment method's issuing institution and ask that they approve authorization requests from AWS.


Note: AWS cancels the authorization request as soon as it's approved by your financial institution. 

You aren't charged for authorization requests from AWS. 

Authorization requests might still appear as a small charge (usually 1 USD) on statements from your financial institution.

Check your email for requests for additional information. Check your email to see if AWS needs any information from you to complete the activation process.


Try a different browser.

Contact AWS Support. Contact AWS Support for help. 

Be sure to mention any troubleshooting steps that you already tried.

Note: Don't provide sensitive information, such as credit card numbers, in any correspondence with AWS.




Available Regions: 

  Code	                 Name
us-east-1	   US East (N. Virginia)
us-east-2	   US East (Ohio)
us-west-1	   US West (N. California)
us-west-2	   US West (Oregon)
ca-central-1	   Canada (Central)
eu-central-1	   EU (Frankfurt)
eu-west-1	   EU (Ireland)
eu-west-2	   EU (London)
eu-west-3	   EU (Paris)
eu-north-1	   EU (Stockholm)
ap-east-1	   Asia Pacific (Hong Kong)
ap-northeast-1	   Asia Pacific (Tokyo)
ap-northeast-2	   Asia Pacific (Seoul)
ap-northeast-3	   Asia Pacific (Osaka-Local)
ap-southeast-1	   Asia Pacific (Singapore)
ap-southeast-2	   Asia Pacific (Sydney)
ap-south-1	   Asia Pacific (Mumbai)
sa-east-1	   South America (São Paulo)













I am tried creating on amazon ubuntu instance 


![image](https://user-images.githubusercontent.com/33985509/59512918-0cb8a700-8eba-11e9-8d6f-1f59475f34eb.png)


ubuntu@ec2-3-82-156-86.compute-1.amazonaws.com


Public DNS (IPv4) :   ec2-3-82-156-86.compute-1.amazonaws.com

IPv4 Public IP Public DNS (IPv4) :   3.82.156.86


![image](https://user-images.githubusercontent.com/33985509/59513135-8e103980-8eba-11e9-9000-731d5a9090e5.png)


## Setup Putty and Puttygen


downloaded puttygen for windows 

Link : https://www.puttygen.com/


Puttygen aka Putty Key Generator


The key generation utility – PuTTYgen can create various public-key cryptosystems including Rivest–Shamir–Adleman (RSA), Digital Signature Algorithm (DSA), Elliptic Curve Digital Signature Algorithm (ECDSA), and Edwards-curve Digital Signature Algorithm (EdDSA) keys.

The aforementioned public-key cryptosystems principally focus on secure data transmission and digital signatures.


Although PuTTYgen collects keys in its native file format i.e. .ppk files, the keys can easily be converted to any file format. 


For Windows, the software interface is PuTTYgen.exe, whereas, for Linux OS the command-line adaptation is available using SSH commands.






Downloaded the pem file from the instance to local pc 


Load the pem and genereate the .ppk file by clicking on generate private key and add in connection settings in putty after providing the hostname


![image](https://user-images.githubusercontent.com/33985509/59513233-b5670680-8eba-11e9-86cd-e74d80ef48ec.png)



![image](https://user-images.githubusercontent.com/33985509/59513291-daf41000-8eba-11e9-9044-570aaf8d9989.png)



save private key will convert the pem to ppk file


![image](https://user-images.githubusercontent.com/33985509/59513465-2dcdc780-8ebb-11e9-8b08-40dedd4ac079.png)



![image](https://user-images.githubusercontent.com/33985509/59517434-e435aa80-8ec3-11e9-9464-693f00ce2f1a.png)


click open on the putty then it will connect to the server



## Seup Terraform


command: terraform init

Run when you start a new working environment

Safe to run mutiple times 

else Error : error satisfying plugin requirement



command: terraform plan

to run before apply

gives complete create/modify plan to visualize



command: terraform apply

Creates all resources



after login in to ubuntu server


go to browser and 

https://www.terraform.io/downloads.html


Right click and copy link 


![image](https://user-images.githubusercontent.com/33985509/59514086-75a11e80-8ebc-11e9-81e2-2c962b43630b.png)


wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip



![image](https://user-images.githubusercontent.com/33985509/59514308-dd576980-8ebc-11e9-9af1-90a4ff611469.png)




![image](https://user-images.githubusercontent.com/33985509/59514392-0b3cae00-8ebd-11e9-8f74-4cba2fd06bce.png)




It won't work if we give terraform with root credentials

root@ip-172-31-83-192:~# terraform

Command 'terraform' not found, but can be installed with:

snap install terraform



export PATH=$PATH:/root

![image](https://user-images.githubusercontent.com/33985509/59518082-35926980-8ec5-11e9-90eb-168aca7e7f51.png)


now if we type terraform in console it will work


For example

root@ip-172-31-83-192:~# terraform
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Workspace management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Validates the Terraform files
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    0.12upgrade        Rewrites pre-0.12 module source code for v0.12
    debug              Debug output management (experimental)
    force-unlock       Manually unlock the terraform state
    push               Obsolete command for Terraform Enterprise legacy (v1)
    state              Advanced state management





https://atom.io/


![image](https://user-images.githubusercontent.com/33985509/59518675-6f17a480-8ec6-11e9-950a-41873956a1ec.png)


![image](https://user-images.githubusercontent.com/33985509/59518830-d3d2ff00-8ec6-11e9-8d7b-6ff057aa7ad9.png)


![image](https://user-images.githubusercontent.com/33985509/59519349-f580b600-8ec7-11e9-9da6-a50fc1bf6f7f.png)




created demo/simpleinstance directory

main.tf


resource "aws_instance" "firtsdemo"
	ami 		= "ami-922914f7"
	instance_type = "t2.micro"

 tags {
   Name = "demoinstance"
   }
}



Error:

![image](https://user-images.githubusercontent.com/33985509/59523003-688e2a80-8ed0-11e9-8ecb-3c4388aa6d93.png)


type terraform init  


then terraform plan


![image](https://user-images.githubusercontent.com/33985509/59523054-8eb3ca80-8ed0-11e9-96c9-ee7b847a4497.png)


![image](https://user-images.githubusercontent.com/33985509/59523203-fbc76000-8ed0-11e9-8c0f-2a2d47203af6.png)



beacuse i need to pass credentails or roles



![image](https://user-images.githubusercontent.com/33985509/59527195-32a27380-8edb-11e9-9bb8-28bbee2b16de.png)



![image](https://user-images.githubusercontent.com/33985509/59527236-477f0700-8edb-11e9-8408-547f4db4c00f.png)



![image](https://user-images.githubusercontent.com/33985509/59527352-a775ad80-8edb-11e9-9d21-0e83d10e2b52.png)



![image](https://user-images.githubusercontent.com/33985509/59527383-bb211400-8edb-11e9-9259-3f3385002508.png)




![image](https://user-images.githubusercontent.com/33985509/59527409-cb38f380-8edb-11e9-90fd-be198f1fd609.png)



![image](https://user-images.githubusercontent.com/33985509/59527556-34206b80-8edc-11e9-8193-4ca79533e35d.png)



Now if i try it will now through error


root@ip-172-31-83-192:~/demo/simpleinstance# terraform plan

provider.aws.region

  The region where AWS operations will take place. 
  
  
  Examples :  are us-east-1, us-west-2, etc.


  Default: us-east-1
 
 
  Enter a value: us-east-2
  


![image](https://user-images.githubusercontent.com/33985509/59524326-d851e480-8ed3-11e9-869b-45fbe014a99b.png)



![image](https://user-images.githubusercontent.com/33985509/59524542-704fce00-8ed4-11e9-831f-82f545633b13.png)




then type terraform apply


![image](https://user-images.githubusercontent.com/33985509/59524873-3b904680-8ed5-11e9-8707-0e6b482742cb.png)



![image](https://user-images.githubusercontent.com/33985509/59525059-a3469180-8ed5-11e9-8cee-ccb79e3c0225.png)



now 



![image](https://user-images.githubusercontent.com/33985509/59525123-d12bd600-8ed5-11e9-872b-378f481b635a.png)



now i check on ohio location my instance is running



![image](https://user-images.githubusercontent.com/33985509/59525202-09cbaf80-8ed6-11e9-8bb6-726a88537656.png)



enter command terraform destroy




![image](https://user-images.githubusercontent.com/33985509/59526212-aee78780-8ed8-11e9-8e7e-22a007a043c3.png)



Error : 

![image](https://user-images.githubusercontent.com/33985509/59526972-95dfd600-8eda-11e9-8268-5be76ea43634.png)




![image](https://user-images.githubusercontent.com/33985509/59527032-ca539200-8eda-11e9-802d-4bad494ff5c3.png)




root@ip-172-31-83-192:~/demo/simpleinstance# terraform -force-unlock




![image](https://user-images.githubusercontent.com/33985509/59527098-f8d16d00-8eda-11e9-9828-233adbdf5fcd.png)








create iam user and pass through provider.tf

Create IAM user and pass through environment varaiables

Attach admin role to instance

Storing it under ~/.aws/




What are IAM roles?

IAM roles are a secure way to grant permissions to entities that you trust. Examples of entities include the following:

IAM user in another account

Application code running on an EC2 instance that needs to perform actions on AWS resources

An AWS service that needs to act on resources in your account to provide its features

Users from a corporate directory who use identity federation with SAML

IAM roles issue keys that are valid for short durations, making them a more secure way to grant access.






![image](https://user-images.githubusercontent.com/33985509/59532108-122ce600-8ee8-11e9-9f6e-9b7514993f8f.png)



![image](https://user-images.githubusercontent.com/33985509/59532171-430d1b00-8ee8-11e9-810b-a03cc5275328.png)



![image](https://user-images.githubusercontent.com/33985509/59532755-edd20900-8ee9-11e9-9651-5f81939ef2ae.png)



here i tried to removed the roles of my ubuntu instance by 


![image](https://user-images.githubusercontent.com/33985509/59545481-03adf100-8f1f-11e9-9337-5eb5c5233c6b.png)


hence  cannot run any terraform commands on my ubuntu  instance 


(IAM user & passing credentails through provider.tf)


Using  below keys we can manage terraform 

Access Key ID: 

Secret access key:

Else we click on  download.csv icon  to get these keys


vi provider.tf

provider "aws"
{

	access_key = "XXXXXXXXXXXXXXXXX"  # AWS Access Key
	secret_key = "XXXXXXXXXXXXXXXXX"  # AWS secret Key
	region = "us-east-2"  # region which i wanted to operate 
}



Now type terraform run

then terraform apply


Hence my instance is created 


(IAM user & passing cedentails through env)


export AWS_ACCESS_KEY="XXXXXXXXXXXXXXXXXXXXXXXXXX"
export AWS_SECRET_KEY="XXXXXXXXXXXXXXXXXXXXXXXXXX" 


i specified the linux,ami-a0cfeed8 in main.tf and name changed ,location to us-west-2


![image](https://user-images.githubusercontent.com/33985509/59549973-878acc00-8f65-11e9-8208-afec39749a35.png)




creating s3bucket



touch s3bucket.tf


vi s3bucket.tf



resource "aws_s3_bucket" "terraform-s3" {

	bucket = "terraform-s3-testing"

	versioning {

		enabled = true

	}

	lifecycle {

		prevent_destroy = true

	}

	tags {

		Name = "S3 Remote store"

	}

}



![image](https://user-images.githubusercontent.com/33985509/59550299-44325c80-8f69-11e9-8fc9-253a33d929a5.png)


need to choose a distinct name,s3 does not depends on the region availability zones

removed the main.tf 

type terraform plan

type terraform apply


root@ip-172-31-83-192:~/demo/simpleinstance# cat s3bucket.tf

resource "aws_s3_bucket" "terraform-s3" {

        bucket = "terraform-s3-coretesting"

        versioning {

                enabled = true

        }

        lifecycle {

                prevent_destroy = true

        }

        tags {

                Name = "S3 chintu test"

        }

}




![image](https://user-images.githubusercontent.com/33985509/59550445-32ea4f80-8f6b-11e9-9a23-9b0a19e3ab0d.png)



Launching multiple instances 

i choose Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type - ami-07a0c6e669965bb7c, Region : us-west-2






![image](https://user-images.githubusercontent.com/33985509/59551270-6b902600-8f77-11e9-95ab-64c0a190412c.png)




resource "aws_instance" "manish" {
	count = 2
	ami 		= "ami-922914f7"
	instance_type = "t2.micro"

 tags {
   Name = "amazonlinux-${count.index}"
   }
}


![image](https://user-images.githubusercontent.com/33985509/59551300-d8a3bb80-8f77-11e9-93e5-cae6720be32e.png)


error because as i deleted provider.tf 

hence type 

export AWS_ACCESS_KEY="XXXXXXXXXXXXXXX"
export AWS_SECRET_KEY="XXXXXXXXXXXXXXXXXXXXXXXXXXX" 

type terraform plan

type terraform apply


Error because ami i did mention belongs to us-east-2


![image](https://user-images.githubusercontent.com/33985509/59551336-3df7ac80-8f78-11e9-8aa0-601a12b99596.png)


now changed

resource "aws_instance" "manish" {
	count = 2
	ami 		= "ami-07a0c6e669965bb7c"
	instance_type = "t2.micro"

 tags {
   Name = "amazonlinux-${count.index}"
   }
}

type terraform plan

type terraform apply


![image](https://user-images.githubusercontent.com/33985509/59551404-37b60000-8f79-11e9-91de-42560a899fad.png)


Hence created instances on us-west-2

![image](https://user-images.githubusercontent.com/33985509/59551415-67fd9e80-8f79-11e9-9375-2407fad3c383.png)



after that i type terraform destroy

hence confirm by 

![image](https://user-images.githubusercontent.com/33985509/59551547-99776980-8f7b-11e9-82b8-410fccd23b01.png)





Variables:

Now i try Red Hat Enterprise Linux 8 (HVM), SSD Volume Type - ami-079596bf7a949ddf8


touch variables.tf

vi touch.tf


variable "amitype" {
}


changed in main.tf

resource "aws_instance" "manish" {
ami = "${var.amitype}"
instance_type = "t2.micro"

 tags {
   Name = "amazonrhel"
   }
}


terraform plan

Enter the ami : ami-079596bf7a949ddf8


![image](https://user-images.githubusercontent.com/33985509/59551825-9ed6b300-8f7f-11e9-9e3c-2cf0ab6ca8e2.png)



adding now some changes to variables.tf


variable "amitype" {
default = "ami-079596bf7a949ddf8"
}



else we can also define this via inline

terraform plan  -var amitype='ami-079596bf7a949ddf8"'






want to pass multiple values as  like for security groups or availability zones.

Or may need multiple availability zones to be pass for resource or you may need to pass multiple security groups for resource.

In those cases you need list variables.

i am taking 

SUSE Linux Enterprise Server 15 (HVM), SSD Volume Type - ami-0be4d33b23ba37935
Red Hat Enterprise Linux 8 (HVM), SSD Volume Type - ami-08949fb6466dd2cf3






In main.tf 

resource "aws_instance" "firstdemo" {
ami = "${lookup(var.ami_type,var.region)}"
security_groups = "${var.sgs}"
instance_type = "${lookup(var.instance_type,var.env)}"

	tags {
	Name = "uswestinstances"
	}
}




In provider.tf

provider "aws"
{

        access_key = "AKIA2JM4R23G5FJ42TQL"  # AWS Access Key
        secret_key = "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"  # AWS secret Key
        region = "us-west-1"  # region which i wanted to operate
}






In variables.tf

variable "ami_type" {
	default = {
	type = "map"
	us-west-1 = "ami-0be4d33b23ba37935"
	us-west-1 = "ami-08949fb6466dd2cf3"

}

}

variable "env" {}
variable "region" {}
variable "instance_type" {

type = "map"
default = { 

	dev = "t2.micro"
	test = "t2.micro"
	
	}

}

variable "sgs" {
	type = "list"

	default = ["sg-07b2fc6c", "sg-48bba323"]
	
}



terraform plan

terraform apply

getting error 


Error: Error applying plan:



1 error(s) occurred:



* aws_instance.manish: 1 error(s) occurred:



* aws_instance.manish: Error launching instance, possible mismatch of Security Group IDs and Names. See AWS Instance docs here: https://terraform.io/docs/providers/aws/r/instance.html.



        AWS Error: Value () for parameter groupId is invalid. The value cannot be empty



Terraform does not automatically rollback in the face of errors.

Instead, your Terraform state file has been partially updated with

any resources that successfully completed. Please address the error

above and apply again to incrementally change your infrastructure.



created new security group 

sg-0038d15c6700fefe3
sg-96a42bcd


Error : persists




DataSources

In main.tf

data "aws_availability_zones" "available" {}

resource "aws_instance" "manish" {

ami = "${lookup(var.ami_type,var.region)}"

availability_zone = "${data.aws_availability_zones.available.names[3]}"

security_groups = "${var.sgs}"

instance_type="${lookup(var.instance_type,var.env)}"

 tags {

   Name = "coreinstance"

 }

}


----------------------

data "aws_availability_zones" "available" {}

resource "aws_rds_cluster" "default" {

cluster_identifier      = "${var.CLUSTER_IDENTIFIER}"

engine                  = "aurora-mysql"

engine_version          = "5.7.12"

availability_zones      = ["${data.aws_availability_zones.available.names}"]

database_name           = "${var.DATABASE_NAME}"

master_username         = "${var.MASTER_USERNAME}"

master_password         = "${var.MASTER_PASSWORD}"

backup_retention_period = 7

preferred_backup_window = "07:00-09:00"

skip_final_snapshot     = "true"

apply_immediately       = "true"

vpc_security_group_ids  = ["${var.VPC_SECURITY_GROUP_IDS}"]

db_subnet_group_name    = "${var.DB_SUBNET_GROUP_NAME}"

tags {

  Name         = "${var.ENVIRONMENT_NAME}-Aurora-DB-Cluster"

  ManagedBy    = "${var.MANAGER}"

  Environment  = "${var.ENVIRONMENT_NAME}"

}

}



if i do a terraform plan

env: dev

region : us-west-1

works



Terraform graph

apt install graphviz

terraform graph | dot -Tpng > graph.png



to get terraform output 

main.tf we can define


output "outputpage" {

	value = "${aws_instance.firstdemo.public_ip}"
}

if i run terraform apply

it will show the output elsetype  terraform output outputpage to display results








interpolation means  ${...}







vpc.tf




data "aws_availability_zones" "available" {}

#main vpc
resource "aws_vpc" "main"
	cidr_block	= "${var.VPC_CIDR_BLOCK}"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	tags {
		Name = "${var.PROJECT_NAME}-vpc
	}
}


# Route table for private subnets

resource "aws_route_table" "private" {
	vpc_id = "${aws_vpv.main.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_nat_gateway.ngw.id}"
	}
	
	tags {
		Name = "${var.PROJECT_NAME}-private-route-table"
		}
	}




#public subnets

#public Subnet 1
resource "aws_subnet" "public_subnet_1"	{
	vpc_id	= "${aws_vpc.main.id}
	cidr_block = "${var.VPC_PUBLIC_SUBNET1_CIDR_BLOCK}"
	availability_zone = "${data.aws_availability_zones.available.names[0]}"
	map_public_ip_on_launch = "true"
	tags {
		Name = "${var.PROJECT_NAME}-vpc-public-subnet-1"
	}
}


#public Subnet 2
resource "aws_subnet" "public_subnet_2" {
	vpc_id = "${aws_vpc.main.id}"
	cidr_block = "${var.VPC_PUBLIC_SUBNET2_CIDR_BLOCK}"
	availability_zone = "${data.aws_availability_zonesavailable.names[1]}"
	map_public_ip_on_lauch = "true"
	tags {
		Name = "${var.PROJECT_NAME}-vpc-public-subnet-2"
	}
}



#private Subnet 1
resource "aws_subnet" "public_subnet_1" {
	vpc_id = "${aws_vpc.main.id}"
	cidr_block = "${var.VPC_PUBLIC_SUBNET1_CIDR_BLOCK}"
	availability_zone = "${data.aws_availability_zonesavailable.names[0]}"
	map_public_ip_on_lauch = "true"
	tags {
		Name = "${var.PROJECT_NAME}-vpc-public-subnet-1"
	}
}

#private Subnet 2
resource "aws_subnet" "public_subnet_2" {
	vpc_id = "${aws_vpc.main.id}"
	cidr_block = "${var.VPC_PUBLIC_SUBNET1_CIDR_BLOCK}"
	availability_zone = "${data.aws_availability_zonesavailable.names[1]}"
	map_public_ip_on_lauch = "true"
	tags {
		Name = "${var.PROJECT_NAME}-vpc-public-subnet-2"
	}
}

#internet gateway
resource "aws_internet_gateway" "igw" {
	vpc_id = "${aws_vpc.main.id}"
	
	tags {
		Name = "${var.PROJECT_NAME}-vpc-internet-gateway"
	}
}

#Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
	vpc = true
	depends_on = {"aws_internet_gateway.igw"}
}

#NAT gateway for private ip address
resource "aws_nat_gateway" "ngw"
	allocation_id = "${aws_eip.nat_eip.id}"
	subnet_id = "${aws_subnet.public_subnet_1.id}
	depends_on = ["aws_internet_gateway.igw"]
	tags {
		Name = "${var.PROJEVT_NAME}-vpc-NAT-gateway"
	}
}

#Route table for public architecture

resource "aws_route_table" "public"
	vpc_id = "${aws_vpc.amin.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.igw.id}"
	}
	
	tags {
		Name = "${var.PROJECT_NAME}-public-route-table"
		
		}
}








