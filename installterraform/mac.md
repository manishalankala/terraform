sudo -i

mkdir -p /opt/terraform

cd /opt/terraform

https://www.terraform.io/downloads.html

curl -O  https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_darwin_amd64.zip

unzip terraform_0.14.6_darwin_amd64.zip

cd ~

sudo vi ~/.bash_profile

PATH="/opt/terraform:${PATH}"

export PATH

Execute the file : source ~/.bash_profile

terraform --version
Terraform v0.14.6
