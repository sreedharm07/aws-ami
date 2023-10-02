data "aws_ami" "ami" {
  name_regex    = "Centos-8-DevOps-Practice"
  owners        = ["973714476881"]
}


resource "aws_instance" "ami" {
  ami                       = data.aws_ami.ami.image_id
  instance_type             = "t3.micro"
  vpc_security_group_ids    = [data.aws_security_group.allow_tls.id]

  tags = {
    Name  = "ami"
  }
}

data "aws_security_group" "allow_tls" {
  name = "allow-all"
}

resource "null_resource" "commands" {
  provisioner "remote-exec" {
   connection {
     user = "centos"
     password = "DevOps321"
     host = "root"
   }
    inline = [
     "labauto ansible"
    ]
  }
}

resource "aws_ami_from_instance" "ami" {
  depends_on = [null_resource.commands]
  name               = "terraform-ami"
  source_instance_id = aws_instance.ami.id
}