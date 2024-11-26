variable "config" {
  type = object({
    project_id   = string
    image_family = string
    image_name   = string
    source_image = string
    ssh_username = string
    ssh_password = string
    machine_type = string
    zone         = string
    disk_type    = string
  })
}