# Create a security group for EC2 instances
resource "aws_security_group" "test-env-sg" {
  name        = "Final-project-Test-env-sg"
  description = "Example security group"
  vpc_id      = var.project_vpc_id
  tags = {
    Name = "Final-project-Test-env-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
}


# Launch EC2 instances
resource "aws_instance" "test_env_instance" {
  count                = 2
  ami                  = var.ami
  instance_type        = "t2.micro"
  subnet_id            = var.public-subnets2_id
  security_groups      = [aws_security_group.test-env-sg.id]
  # iam_instance_profile = aws_iam_instance_profile.test-env-admin-role.name
  key_name             = "devops-project-test-env-key"
  user_data            = file("user_data.sh")
  tags = {
    Name = "Test-env-instance-${count.index + 1}"
  }
}

# Create an Elastic Load Balancer (ELB)
resource "aws_elb" "test_env_LB" {
  name     = "Test-env-LB"
  internal = false
  #load_balancer_type         = "application"
  #enable_deletion_protection = false
  subnets = [var.public-subnets2_id]
  tags = {
    Name = "Web HA ELB"
  }

  listener {
    instance_port     = "80"
    instance_protocol = "http"
    lb_port           = "80"
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
