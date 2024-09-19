source "virtualbox-iso" "windows-server" {
  boot_wait            = "${var.config.boot_wait}"
  communicator         = "winrm"
  disk_size            = "${var.config.disk_size}"
  floppy_files         = ["autounattend/autounattend.xml"]
  guest_additions_mode = "disable"
  guest_os_type        = "Windows2016_64"
  headless             = true
  iso_checksum         = "${var.config.iso_checksum}"
  iso_url              = "${var.config.iso_url}"
  shutdown_command     = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout     = "30m"
  vboxmanage = [
    [
      "modifyvm", "{{ .Name }}", "--memory", "${var.config.memsize}"
    ],
    [
      "modifyvm", "{{ .Name }}",
      "--cpus", "${var.config.numvcpus}"
    ]
  ]
  vm_name        = "${var.config.vm_name}"
  winrm_insecure = true
  winrm_password = "${var.config.winrm_password}"
  winrm_timeout  = "4h"
  winrm_use_ssl  = true
  winrm_username = "${var.config.winrm_username}"
}

build {

  #name = "windows-server-image-{{isotime `02-Jan-06_03_04_05`}}"
  sources = ["source.virtualbox-iso.windows-server"]

  provisioner "powershell" {
    only         = ["virtualbox-iso"]
    pause_before = "1m0s"
    scripts      = ["scripts/virtualbox-guest-additions.ps1"]
  }

  provisioner "powershell" {
    scripts = ["scripts/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    pause_before = "1m0s"
    scripts      = ["scripts/cleanup.ps1"]
  }

}


	