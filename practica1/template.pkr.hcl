source "vagrant" "aisi" {
  communicator = "ssh"
  source_path  = "ubuntu/jammy64"
  box_version  = "20240207.0.0"
  provider     = "virtualbox"
  add_force    = true
  skip_add     = true
  template     = "provisioning/Vagrantfile.template"
}

build {
  sources = ["source.vagrant.aisi"]

  provisioner "shell" {
    script  = "C:/Users/aaron/Documents/Q8/AISI/practica1/provisioning/install-docker-ubuntu.sh"
    timeout = "120s"
  }
}