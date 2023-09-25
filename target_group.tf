# Create a target group
resource "aws_lb_target_group" "test_env_TG" {
  name     = "Test-env-TG"
  port     = 7070
  protocol = "HTTP"
  vpc_id   = var.project_vpc_id

  health_check {
    enabled = true
    port     = 8088
    path     = "/health"
    protocol = "HTTP"
    interval = 30
    healthy_threshold = 3
    unhealthy_threshold = 3
    
  }
}

# Attach instances to the target group
resource "aws_lb_target_group_attachment" "attach_tg_to_lb" {
  count           = length(aws_instance.test_env_instance)
  target_group_arn = aws_lb_target_group.test_env_TG.arn
  target_id        = aws_instance.test_env_instance[count.index].id
  port = 7070
}