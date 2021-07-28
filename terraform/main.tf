data "aws_ami" "spring-petclinic-rest" {
  most_recent = true

  # Prod account
  owners           = ["519911613414"]
  executable_users = ["self"]

  filter {
    name   = "name"
    values = ["spring-petclinic-rest-*"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 1.66"

  name = "spring-petclinic"
  cidr = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Terraform = "true"
  }
}
