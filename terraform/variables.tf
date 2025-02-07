variable "ami_checksum" {
  description = "'Checksum' tag used to choose the spring-petclinic-rest AMI"
}

variable "min_instances" {
  default = 2
}

variable "max_instances" {
  default = 4
}

variable "region" {
  default = "ap-south-1"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}
