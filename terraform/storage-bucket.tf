resource "google_storage_bucket" "cloud_function_src_bucket" {
  name     = "cloud-function-${var.project_id}"
  location = var.region
#   project  = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "input_bucket" {
  name     = "input-${var.project_id}"
  location = var.region
  uniform_bucket_level_access = true
#   project  = var.project_id
}