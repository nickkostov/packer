packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "1.1.6"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "1.1.1"
    }
  }
}