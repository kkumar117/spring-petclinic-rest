# Note: changing the version of the modules will cause the security groups to be recreated.

module "spring-petclinic-rest" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "2.4.0"

  name        = "spring-petclinic-rest"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/https-443"
  version = "2.4.0"

  name                = "alb_sg"
  description         = "Security group for web-server with HTTPS ports open publicly"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "alb_http_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "2.4.0"

  name                = "alb_http_sg"
  description         = "Security group for web-server with HTTP ports open publicly"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
}
