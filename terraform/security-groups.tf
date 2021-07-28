
resource "aws_security_group" "spring-petclinic-rest" {
  name        = "spring-petclinic-rest"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 9966
    to_port          = 9966
    protocol         = "http"
    cidr_blocks      = [module.vpc.cidr_block]
  }

  tags = {
    Name = "spring-petclinic-rest"
  }
}

resource "aws_security_group" "rest-alb" {
  name        = "rest-alb"
  description = "Security group for HTTP ports for public internet"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "http"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rest-alb"
  }
}
