source "virtualbox-iso" "debian" {
  boot_command = [
    "<esc><wait>", "install <wait>",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "debian-installer=en_US.UTF-8 <wait>",
    "auto <wait>", "locale=en_US.UTF-8 <wait>", "kbd-chooser/method=us <wait>",
    "keyboard-configuration/xkb-keymap=us <wait>", "netcfg/get_hostname={{ .Name }} <wait>",
    "netcfg/get_domain=vagrantup.com <wait>", "fb=false <wait>",
    "debconf/frontend=noninteractive <wait>", "console-setup/ask_detect=false <wait>",
    "console-keymaps-at/keymap=us <wait>", "grub-installer/bootdev=/dev/sda <wait>",
    "<enter><wait>"
  ]
  boot_wait            = var.config.boot_wait
  communicator         = "ssh"
  disk_size            = var.config.disk_size
  guest_additions_path = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type        = "Debian_64"
  headless             = true
  http_directory       = "http"
  iso_checksum         = var.config.iso_checksum
  iso_urls             = var.config.iso_url
  shutdown_command     = "echo 'Automatic Shutdown'|sudo -S shutdown -P now"
  ssh_password         = var.config.ssh_password
  ssh_username         = var.config.ssh_username
  ssh_port             = 22
  ssh_wait_timeout     = "1800s"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", var.config.memsize],
    ["modifyvm", "{{ .Name }}", "--cpus", var.config.numvcpus]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = format("debian-%s", var.config.vm_name)
}

build {
  sources = ["source.virtualbox-iso.debian"]


  provisioner "shell" {
    execute_command = "echo '${var.config.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "scripts/ansible.sh",
      "scripts/setup.sh",
      "scripts/docker_install.sh",
      "scripts/cleanup.sh"
    ]
  }
  provisioner "ansible-local" {
    # galaxy_file   = "shared/requirements.yml"
    playbook_file = "shared/main.yml"
  }
  provisioner "file" {
    source      = "files/jenkins-agent.service"
    destination = "/home/jenkins/jenkins-agent.service"
  }
  provisioner "file" {
    source      = "files/secret-file"
    destination = "/home/jenkins/secret-file"
  }
  provisioner "shell" {
    execute_command = "echo '${var.config.ssh_password}' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "scripts/jenkins-config.sh",
    ]
  }
  post-processors {
    post-processor "vagrant" {
      output = "builds/{{ .Provider }}-{{ timestamp }}-{{uuid}}.box"
    }

  }
}
