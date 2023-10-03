resource "digitalocean_droplet" "www-1" {
  image    = "ubuntu-23-04-x64"
  name     = "www-1"
  region   = "fra1"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = [data.digitalocean_ssh_key.terraform.id]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }

  user_data = file("../cloud-init/user-data.yml")

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} ../ansible/playbook.yml"
  }
}
