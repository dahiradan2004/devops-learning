output "ip_address" {
    description = "This is your public IP address"
    value = aws_instance.cloud-init.public_ip
}