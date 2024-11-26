locals {
  install_packages = [
    # Optional but recommended zip"
  ]
}

source "googlecompute" "this" {
  project_id   = var.config.project_id
  image_family = var.config.image_family
  image_description = "Debian Image Built"
  image_name   = format("debian-%s-{{ timestamp }}", var.config.image_name)
  source_image = format("debian-%s", var.config.source_image)
  ssh_username = var.config.ssh_username
  ssh_password = var.config.ssh_password
  machine_type = var.config.machine_type
  zone         = var.config.zone
  disk_type    = var.config.disk_type
  image_labels = {
    "packer" = "true",
    "application" = "jenkins",
    "env" = "nonprod"
  }
}

build {
  sources = [
    "source.googlecompute.this",
  ]

  // Install dependencies
  provisioner "shell" {
    inline = [
      # Install dependencies
      "sudo apt-get update",
      format("sudo apt-get install --assume-yes %s", join(" ", local.install_packages)),

      # Install Google Cloud Ops Agent
      "curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh",
      "sudo bash add-google-cloud-ops-agent-repo.sh --also-install",
    ]
  }
  provisioner "shell" {
    execute_command = "echo '${var.config.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "../debian-shared-scripts/bash-scripts/setup.sh",
      "../debian-shared-scripts/bash-scripts/install-docker.sh",
      "../debian-shared-scripts/bash-scripts/clean-up.sh"
    ]
  }
  provisioner "shell" {
    execute_command = "echo '${var.config.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "../debian-shared-scripts/bash-scripts/install-ansible.sh",
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "../debian-shared-scripts/ansible-playbooks/main.yml"
  }
}