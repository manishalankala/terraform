# terraform



![image](https://user-images.githubusercontent.com/33985509/59514648-94ec7b80-8ebd-11e9-928b-40d18609a767.png)










Trying on amazon ubuntu instance 


![image](https://user-images.githubusercontent.com/33985509/59512918-0cb8a700-8eba-11e9-8d6f-1f59475f34eb.png)


ubuntu@ec2-3-82-156-86.compute-1.amazonaws.com


Public DNS (IPv4) :   ec2-3-82-156-86.compute-1.amazonaws.com

IPv4 Public IP Public DNS (IPv4) :   3.82.156.86


![image](https://user-images.githubusercontent.com/33985509/59513135-8e103980-8eba-11e9-9000-731d5a9090e5.png)



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


type terraform init  then terraform plan

![image](https://user-images.githubusercontent.com/33985509/59523054-8eb3ca80-8ed0-11e9-96c9-ee7b847a4497.png)


![image](https://user-images.githubusercontent.com/33985509/59523203-fbc76000-8ed0-11e9-8c0f-2a2d47203af6.png)



beacuse i need to pass credentails or roles


![image](https://user-images.githubusercontent.com/33985509/59523431-8a3be180-8ed1-11e9-9940-d5b61fb2bf71.png)



![image](https://user-images.githubusercontent.com/33985509/59523548-e69f0100-8ed1-11e9-9509-5109777a0b8c.png)





![image](https://user-images.githubusercontent.com/33985509/59523677-2c5bc980-8ed2-11e9-9fa3-a12bfe19fb94.png)





![image](https://user-images.githubusercontent.com/33985509/59523688-35e53180-8ed2-11e9-8355-9597adcc4189.png)





![image](https://user-images.githubusercontent.com/33985509/59523740-5d3bfe80-8ed2-11e9-9789-98bfe9a19246.png)





![image](https://user-images.githubusercontent.com/33985509/59523950-e94e2600-8ed2-11e9-9552-cfa8216b682e.png)




![image](https://user-images.githubusercontent.com/33985509/59523997-08e54e80-8ed3-11e9-9f12-f3891e709218.png)





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







