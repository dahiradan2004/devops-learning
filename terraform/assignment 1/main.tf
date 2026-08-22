provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "wordpress" {
    ami = var.instance_ami
    instance_type = var.instance_type
    user_data = file("userdata.sh")
    key_name = "DahirProject"
    vpc_security_group_ids = [aws_security_group.wordpress_sg.id]
}

resource "aws_security_group" "wordpress_sg"{
    ingress{
        from_port = 80
        to_port   = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress{
        from_port = 22
        to_port   = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}

}