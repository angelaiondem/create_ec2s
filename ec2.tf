# Launch EC2 instances
resource "aws_instance" "test_env_instance" {
  count                = 2
  ami                  = var.ami
  instance_type        = "t2.micro"
  subnet_id            = var.public-subnets2_id
  security_groups      = [aws_security_group.ec2_sg.id, aws_security_group.ec2_sg_ssh.id]
  iam_instance_profile = aws_iam_instance_profile.test-env-admin-role.name
  key_name             = "devops-project-test-env-key"
  user_data            = file("user_data.sh")
  tags = {
    Name = "Test-env-instance-${count.index + 1}"
  }
}