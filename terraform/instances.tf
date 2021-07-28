module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 3.5"

  load_balancer_name = "spring-petclinic-rest"
  security_groups    = [module.alb_sg.this_security_group_id, module.alb_http_sg.this_security_group_id]

  subnets = module.vpc.public_subnets
  vpc_id  = module.vpc.vpc_id

  http_tcp_listeners = [
    {
      "port"     = 80
      "protocol" = "HTTP"
    }
  ]

  http_tcp_listeners_count = "1"

  idle_timeout = "600"

  target_groups = [
    {
      "name"              = "spring-petclinic-rest"
      "backend_protocol"  = "HTTP"
      "backend_port"      = "9966"
      "health_check_path" = "/petclinic/actuator/health"
    },
  ]

  target_groups_count = "1"

  tags = map("spring-petclinic-rest", "backend")
}

data "template_file" "launch_spring_bootstrap" {
  template = file("user_data/config.sh.tpl")
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 2.9"

  name            = "spring-petclinic-rest"
  lc_name         = "spring-petclinic-rest"
  image_id        = data.aws_ami.spring-petclinic-rest.id
  instance_type   = "t2.micro"
  security_groups = [module.spring-petclinic-rest.this_security_group_id]

  # Increase root block device size
  root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    }
  ]

  # Auto scaling group
  asg_name                  = "spring-petclinic-rest-asg"
  vpc_zone_identifier       = module.vpc.public_subnets
  health_check_type         = "EC2"
  min_size                  =  var.min_instances
  max_size                  = var.max_instances
  desired_capacity          = var.min_instances
  wait_for_capacity_timeout = 0
  target_group_arns         = module.alb.target_group_arns

  tags = [
    {
      key                 = "spring-petclinic-rest"
      value               = "backend"
      propagate_at_launch = true
    }
  ]

  user_data = data.template_file.launch_spring_bootstrap.rendered
}
