# Create an Elastic Load Balancer (ELB)
resource "aws_elb" "test_env_LB" {
  name            = "Test-env-LB"
  security_groups = [aws_security_group.test-env-sg.id]
  availability_zones = [data.aws_availability_zones.available[*].names]
  subnets = [var.public-subnets1_id, var.var.public-subnets2_id ]
  tags = {
    Name = "Web HA ELB"
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "3"
    target              = "HTTP:80/"
    interval            = "10"
  }
}