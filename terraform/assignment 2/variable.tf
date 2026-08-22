variable "region" {
  type = string
  default = "eu-west-2"
}

variable "ami_instance" {
    type = string
    default = "ami-054818ecdf7d5ec33"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}