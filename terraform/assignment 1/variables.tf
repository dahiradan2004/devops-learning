variable "aws_region" {
    type = string
    default = "eu-west-2"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "instance_ami" {
  type = string
  default = "ami-054818ecdf7d5ec33"
}
