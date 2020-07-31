resource "google_storage_bucket" "simple-bucket" {
  name = "simple-bucket-def"
  location = "europe-west1"
}


# Provider for generated temporary token
provider "google" {
  project = var.project
  alias  = "token_gen"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}


data "google_service_account_access_token" "default" {
  provider               = google.token_gen
  target_service_account = var.terraform_service_account

  scopes = [
    "userinfo-email",
    "cloud-platform",
  ]

  lifetime = "300s"
}

# provider for deploy resources
provider "google" {
  project = var.project
  version      = "~> 3.0"
  access_token = data.google_service_account_access_token.default.access_token
}

variable "terraform_service_account" {
}

variable "project" {
}

