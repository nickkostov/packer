source "virtualbox-iso" "debian" {
  boot_command            = ["<esc><wait>", "install <wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>", "debian-installer=en_US.UTF-8 <wait>", "auto <wait>", "locale=en_US.UTF-8 <wait>", "kbd-chooser/method=us <wait>", "keyboard-configuration/xkb-keymap=us <wait>", "netcfg/get_hostname={{ .Name }} <wait>", "netcfg/get_domain=vagrantup.com <wait>", "fb=false <wait>", "debconf/frontend=noninteractive <wait>", "console-setup/ask_detect=false <wait>", "console-keymaps-at/keymap=us <wait>", "grub-installer/bootdev=/dev/sda <wait>", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 81920
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Debian_64"
  headless                = true
  http_directory          = "http"
  iso_checksum            = "7892981e1da216e79fb3a1536ce5ebab157afdd20048fe458f2ae34fbc26c19b"
  iso_urls                = ["debian-11.3.0-amd64-netinst.iso", "https://cdimage.debian.org/cdimage/archive/11.3.0/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"]
  shutdown_command        = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_username            = "vagrant"
  ssh_wait_timeout        = "1800s"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "1024"], ["modifyvm", "{{ .Name }}", "--cpus", "1"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-debian-11-amd64"
}

build {
  sources = ["source.virtualbox-iso.debian"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/ansible.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/setup.sh"
  }

  provisioner "ansible-local" {
    # galaxy_file   = "../shared/requirements.yml"
    playbook_file = "../shared/main.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/cleanup.sh"
  }
  post-processors {
    post-processor "vagrant" {
      output = "builds/{{ .Provider }}-debian11.box"
    }
  }
}
