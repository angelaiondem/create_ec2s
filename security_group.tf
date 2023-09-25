# Create a security group for EC2 instances
resource "aws_security_group" "ec2_sg" {
  name        = "Final-project-Test-env-sg-ec2"
  description = "Test environment EC2 SG"
  vpc_id      = var.project_vpc_id
  tags = {
    Name = "Final-project-Test-env-sg-EC2"
  }
}

# Create a security group for LB.
resource "aws_security_group" "lb_sg" {
  name        = "Final-project-Test-env-elb"
  description = "Test environment LB SG"
  vpc_id      = var.project_vpc_id
  tags = {
    Name = "Final-project-Test-env-sg-LB"
  }
}

# Ingress rule for EC2 traffic
resource "aws_security_group_rule" "ingress_ec2_traffic" {
  type                     = "ingress"
  from_port                = 7070
  to_port                  = 7070
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
}

# Ingress rule for EC2 health check
resource "aws_security_group_rule" "ingress_ec2_health_check" {
  type                     = "ingress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
}

# Egress rule for EC2 traffic
resource "aws_security_group_rule" "full_egress_ec2_traffic" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

# Ingress rule for LB traffic
resource "aws_security_group_rule" "ingress_alb_traffic" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

# Egress rule for LB traffic
resource "aws_security_group_rule" "egress_alb_traffic" {
  type                     = "egress"
  from_port                = 7070
  to_port                  = 7070
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lb_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
}

# Egress rule for LB health check
resource "aws_security_group_rule" "egress_alb_health_check" {
  type                     = "egress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lb_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
}


# Create a security group for EC2 instances
resource "aws_security_group" "ec2_sg_ssh" {
  name        = "Final-project-Test-env-sg-ec2-ssh"
  description = "Test environment EC2 SG"
  vpc_id      = var.project_vpc_id
  tags        = { Name = "Final-project-Test-env-sg-EC2" }

  ingress {
    description = "Allow SSH from the local network."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from the local network."
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
