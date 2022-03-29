resource "aws_instance" "aws-efs" {
  ami                    = "${var.instance_ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_ids}"
  vpc_security_group_ids = ["${aws_security_group.aws-efs-sg.id}"]
  tags = {
    Name = "aws-efs"
  }


  key_name = "${aws_key_pair.efs-key-pair.id}"

}



# Security Group primary


resource "aws_security_group" "aws-efs-sg" {
  name   = "aws-efs-sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-efs-sg"
  }
}





# key pair primary 


resource "aws_key_pair" "efs-key-pair" {
    key_name = "efs-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}



resource "null_resource" "aws-efs" {
  connection {
    host = aws_instance.arviu-aws-efs.public_ip
    agent = true
    user = "${var.EC2_USER}"
  }

  provisioner "remote-exec" {
     inline = [ 
      "sudo apt-get update -y",
      "sudo apt-get install nfs-common -y",
      "sudo apt-get install python3.8 -y",
      "sudo apt-get install python3-pip -y",
      "python --version",
      "python3 --version",       
"sudo mkdir /efs",
"echo ${aws_efs_file_system.aws-efs.dns_name}",
"sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.aws-efs.dns_name}:/ /efs",
"df -h",
"ls -ltr /efs"
]      
    
  }
    depends_on = [aws_instance.arviu-aws-efs]

}
