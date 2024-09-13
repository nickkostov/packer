packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> 1"
    }
  }
}

variable "autounattend" {
  type    = string
  default = "./answer_files/2016/Autounattend.xml"
}

variable "iso_checksum" {
  type    = string
  default = "70721288bbcdfe3239d8f8c0fae55f1f"
}

variable "iso_checksum_type" {
  type    = string
  default = "md5"
}

variable "iso_url" {
  type    = string
  default = "http://download.microsoft.com/download/1/4/9/149D5452-9B29-4274-B6B3-5361DBDA30BC/14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_EN-US.ISO"
}


source "virtualbox-iso" "autogenerated_2" {
  boot_wait         = "2m"
  disk_size         = 61440
  floppy_files      = ["${var.autounattend}", "./scripts/microsoft-updates.bat", "./scripts/win-updates.ps1", "./scripts/openssh.ps1"]
  guest_os_type     = "Windows2016_64"
  headless          = true
  iso_checksum      = "${var.iso_checksum}"
  iso_checksum_type = "${var.iso_checksum_type}"
  iso_url           = "${var.iso_url}"
  shutdown_command  = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  ssh_password      = "vagrant"
  ssh_username      = "vagrant"
  ssh_wait_timeout  = "6h"
  vboxmanage        = [["modifyvm", "{{ .Name }}", "--memory", "2048"], ["modifyvm", "{{ .Name }}", "--cpus", "2"]]
}