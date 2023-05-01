resource "aws_instance" "app-server" {
  ami                     = var.ami-id
  instance_type           = var.instance-type
 
    tags = {

        Name = var.ec2-name
    }
 }