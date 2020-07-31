resource "google_project" "my_project_in_a_folder" {
  name            = var.project_id
  project_id      = var.project_id
  folder_id       = var.parent_folder_id
  billing_account = var.billing_account_id
}

locals {
  services = ["container.googleapis.com"]
}

resource "google_project_service" "services" {
  for_each = toset(local.services)
  project = google_project.my_project_in_a_folder.project_id
  service = each.value

}


variable "project_id" {}
variable "parent_folder_id" {}
variable "billing_account_id" {}
