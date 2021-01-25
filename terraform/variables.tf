
# variables.tf
#################################
#             REGION            #
#################################

variable "region" {
  type    = string
  default = "eu-west-3"
}

#################################
#            INSTANCE           #
#################################

variable "create_instance" {
  type    = bool
  default = true
}

variable "instance_number" {
  type    = number
  default = 1
}

variable "instance_name" {
    type = string
    default = "instance_marceau_del"
}

variable "instance" {
  type    = string
  default = "t2.micro"
}

#################################
#               VPC             #
#################################

variable "id_vpc" {
    type = string
    default = "vpc-891839e0"
}

#################################
#             PORTS             #
#################################

variable "ssh_key" {
  type    = string
  default = "tp_dev_ynov"
}

variable "ssh" {
    type = number
    default = 22
}

variable "http" {
    type = number
    default = 80
}






#####################

variable "ami" {
  type    = string
  default = "ami-0b209583a4a1146dd"
}

