config = {
  project_id   = "mps-infra-shared-nonprod"
  image_family = "debian-12"
  image_name   = "jenkins-master"
  # Like this to change directly OS version and Cloud Provider Version
  source_image = "12-bookworm-v20240910"
  ssh_username = "jenkins"
  ssh_password = "jenkins"
  machine_type = "e2-small"
  zone         = "europe-southwest1-a"
  disk_type    = "pd-standard"
}