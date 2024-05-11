output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = [for k, v in aws_instance.ubuntu : v.public_ip]
}