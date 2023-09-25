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
