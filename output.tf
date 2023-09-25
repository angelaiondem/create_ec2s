output "web_load_balancer_url" {
    value = aws_lb.test_env_LB.dns_name
}

output "instance1_ip" {
    value = aws_instance.test_env_instance[0].private_ip
}

output "instance2_ip" {
    value = aws_instance.test_env_instance[1].private_ip
}