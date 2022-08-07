variable "region" {
    type = string
  default = "eu-west-1"
}

variable "ami" {
  type = string
  default = "ami-089950bc622d39ed8"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}