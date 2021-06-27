sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/$release/hashicorp.repo

sudo yum update

sudo yum install terraform
