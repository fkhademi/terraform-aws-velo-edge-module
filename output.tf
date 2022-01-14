output "private_ip" {
  description = "Velo LAN IP"
  value       = aws_network_interface.private
}

output "public_ip" {
  description = "Velo WAN IP"
  value       = aws_network_interface.public
}

output "instance" {
  description = "Velocloud instance and its attributes"
  value       = aws_instance.velo
}
