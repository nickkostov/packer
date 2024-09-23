variable "config" {
  type = object({
    boot_wait      = string
    disk_size      = number
    iso_checksum   = string
    iso_urls       = list(string)
    memsize        = number
    numvcpus       = number
    vm_name        = string
    winrm_password = string
    winrm_username = string
  })

  default = {
    boot_wait    = "10s"
    disk_size    = 40960 # Size in MB (e.g., 50 GB)
    iso_checksum = "md5:70fec2cb1d6759108820130c2b5496da"
    iso_urls     = ["windows_server2019.iso", "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"]
    # iso_url = "https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
    memsize        = 2048 # RAM size in MB (e.g., 4 GB)
    numvcpus       = 2    # Number of CPUs
    vm_name        = "Win2019_17763"
    winrm_password = "jenkins"
    winrm_username = "Administrator"
  }
}
