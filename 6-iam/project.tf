resource "google_project" "my_project_in_a_folder" {
  name            = var.project_id
  project_id      = var.project_id
  folder_id       = var.parent_folder_id
  billing_account = var.billing_account_id
}

resource "google_project_iam_policy" "project" {
  project     = google_project.my_project_in_a_folder.project_id
  policy_data = data.google_iam_policy.admin.policy_data
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/viewer"

    members = [
      "user:user@xxxxx.xx",
    ]
  }

  binding {
    role = "roles/owner"

    members = [
      "group:admin@xxxxxx.xxx",
    ]
  }
}

resource "google_storage_bucket" "simple-bucket" {
  name = "simple-bucket-abc"
  location = "europe-west1"
}

resource "google_storage_bucket_iam_member" "user_can_view_simple_bucket_object" {
  bucket = google_storage_bucket.simple-bucket.name
  role = "roles/storage.objectViewer"
  member =  "user:user@xxxxx.xx",
}
resource "google_storage_bucket_iam_member" "admin_is_storage_admin_in_simple_bucket" {
  bucket = google_storage_bucket.simple-bucket.name
  role = "roles/storage.admin"
  member =  "group:admin@xxxxxx.xxx",
}


variable "project_id" {}
variable "parent_folder_id" {}
variable "billing_account_id" {}
