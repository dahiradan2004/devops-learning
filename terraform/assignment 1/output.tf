output "wordpress_public_ip" {
    description = "This is the public IP of your server"
    value = aws_instance.wordpress.public_ip
}