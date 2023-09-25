# Create an Elastic Load Balancer (ELB)
resource "aws_lb" "test_env_LB" {
  name            = "Test-env-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb_sg.id]
  subnets = [var.public-subnets1_id, var.public-subnets2_id ]
  tags = {
    Name = "Web HA ELB"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.test_env_LB.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_env_TG.arn
  }
}