data "google_organization" "org" {
  domain = var.org_domain
}

resource "google_folder" "my_folder" {
  display_name = "my_folder"
  parent       = data.google_organization.org.name
}



variable "org_domain" {
}

variable "project" {
}
provider "google" {
  project = var.project
  alias  = "token_gen"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}


variable "terraform_service_account" {
  default = ""
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
