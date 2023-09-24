# resource "aws_iam_user" "user" {
#   name = "test-user"
# }

# resource "aws_iam_group" "group" {
#   name = "test-group"
# }

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


# # Attach an instance profile to the IAM role
# resource "aws_iam_instance_profile" "test-env-admin-role" {
#   name = "test-env-admin-role"
#   role = aws_iam_role.admin.name
# }
