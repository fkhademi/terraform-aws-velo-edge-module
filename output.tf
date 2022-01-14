output "private_ip" {
  description = "Velo LAN IP"
  value       = aws_network_interface.private.private_ip
}