output "public_ip_address" {
  value = aws_instance.flask-server.public_ip
}

output "flask_url" {
  value = "http://${aws_instance.flask-server.public_ip}"
}
