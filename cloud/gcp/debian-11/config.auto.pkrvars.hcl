config = {
  project_id   = "mps-infra-shared-nonprod"
  image_family = "debian-11"
  image_name   = "jenkins-master"
  # Like this to change directly OS version and Cloud Provider Version
  source_image = "11-bullseye-v20240910"
  ssh_username = "packer"
  machine_type = "e2-micro"
  zone         = "europe-southwest1-a"
  disk_type    = "pd-standard"
}