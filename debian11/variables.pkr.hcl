variable "version" {
  type    = string
  default = ""
}

variable "config" {
  type = object({
    boot_wait    = string
    disk_size    = number
    iso_checksum = string
    iso_url      = list(string)
    memsize      = number
    numvcpus     = number
    ssh_password = string
    ssh_username = string
    vm_name = string
  })
  default = {
    boot_wait    = "5s"
    disk_size    = 40960 # Size in MB (e.g., 50 GB)
    iso_checksum = "7892981e1da216e79fb3a1536ce5ebab157afdd20048fe458f2ae34fbc26c19b"
    iso_url      = ["debian-11.3.0-amd64-netinst.iso", "https://cdimage.debian.org/cdimage/archive/11.3.0/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"]
    memsize      = 2048 # RAM size in MB (e.g., 4 GB)
    numvcpus     = 2   # Number of CPUs
    vm_name      = "jenkins"
    ssh_password = "jenkins"
    ssh_username = "jenkins"
  }

}