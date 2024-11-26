locals {
  # System dependencies required for Aspect Workflows
  install_packages = [
    # Dependencies of Aspect Workflows
    "fuse",                  # required for the Workflows high-performance remote cache configuration
    "git",                   # required so we can fetch the source code to be tested, obviously!
    "google-osconfig-agent", # Google operational monitoring tools used to collect and alarm on critical telemetry
    "rsync",                 # reqired for bootstrap
    # Optional but recommended dependencies
    "patch", # patch may be used by some rulesets and package managers during dependency fetching
    "zip"
  ]
}

source "googlecompute" "this" {
  project_id   = var.config.project_id
  image_family = var.config.image_family
  image_name   = format("debian-%s-{{ timestamp }}", var.config.image_name)
  source_image = format("debian-%s", var.config.source_image)
  ssh_username = var.config.ssh_username
  machine_type = var.config.machine_type
  zone         = var.config.zone
  disk_type    = var.config.disk_type
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
    #execute_command = "echo '${var.config.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "./debian-golden-image/debian-shared-scripts/bash-scripts/install-ansible.sh",
      "./debian-golden-image/debian-shared-scripts/bash-scripts/setup.sh",
      "./debian-golden-image/debian-shared-scripts/bash-scripts/install-docker.sh",
      "./debian-golden-image/debian-shared-scripts/bash-scripts/cleanup.sh"
    ]
  }
  provisioner "ansble" {
    playbook_file = "./debian-golden-image/debian-shared-scripts/ansible-playbooks/main.yml"
  }
}