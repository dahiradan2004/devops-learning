provider "aws" {
  region = var.region

}
resource "aws_instance" "cloud-init" {
    ami = var.ami_instance
    instance_type = var.instance_type
    user_data_base64 = base64encode(file("cloud-init.yaml"))
    key_name = "DahirProject"
    vpc_security_group_ids = [aws_security_group.cloud_init_sg.id]
}

resource "aws_security_group" "cloud_init_sg" {
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
 