# Create a target group
resource "aws_lb_target_group" "test_env_TG" {
  name     = "Test-env-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.project_vpc_id

  health_check {
    path     = "/health"
    protocol = "HTTP"
    port     = "80"
  }
}

# Attach instances to the target group
resource "aws_lb_target_group_attachment" "attach_tg_to_lb" {
  count            = 2
  target_group_arn = aws_lb_target_group.test_env_TG.arn
  target_id        = aws_instance.test_env_instance[count.index].id
}