# Create an IAM role for EC2 instances
resource "aws_iam_role" "ec2_admin_role" {
  name = "EC2AdminRole"
    assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Create an IAM admin policy
resource "aws_iam_policy" "admin_policy" {
  name        = "EC2AdminPolicy"
  description = "Policy for EC2 Admin role"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "*",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

# Attache role and policy
resource "aws_iam_policy_attachment" "admin_policy_attachment" {
  name       = "EC2AdminPolicyAttachment"
  policy_arn = aws_iam_policy.admin_policy.arn
  roles      = [aws_iam_role.ec2_admin_role.name]
}

# Attach an instance profile to the IAM role
resource "aws_iam_instance_profile" "test-env-admin-role" {
  name = "test-env-admin-role"
  role = aws_iam_role.ec2_admin_role.name
}


# # Create an IAM role for EC2 instances
# resource "aws_iam_role" "admin" {
#   name = "Test-env-admin-role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Action" : "*",
#       "Resource" : "*"
#     }
#   ]
# }
# EOF
# }


