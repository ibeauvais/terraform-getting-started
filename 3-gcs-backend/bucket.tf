resource "google_storage_bucket" "simple-bucket" {
  name = "simple-bucket-abc"
  location = "europe-west1"
}

provider "google" {
  project = var.project
}

variable "project" {
}


terraform {
  backend "gcs" {
  }
}
