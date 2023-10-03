output "ip_address" {
  value = digitalocean_droplet.www-1.ipv4_address
  description = "The public IP address of your Droplet application."
}
