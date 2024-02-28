locals {
  # Ids for multiple sets of EC2 instances, merged together
  filename = "cloud-function-0.0.1"
  filenameext = "${local.filename}.zip"
  archive_path = "../dist/${local.filenameext}"
  hashed_archive_path = md5(local.archive_path)
  
}

terraform {
  backend "gcs" {
    bucket = "gcp-cloud-function-terraform-bucket-34242422" # GCS bucket name to store terraform tfstate
    prefix = "function"               # Prefix name should be unique for each Terraform project having same remote state bucket.
  }
  # backend "local" {}
}

# Add source code zip to the Cloud Function's bucket (cloud_function_src_bucket) 
resource "google_storage_bucket_object" "zip" {
  source       =  local.archive_path
  content_type = "application/zip"
  name         = "${local.filenameext}"
  bucket       = google_storage_bucket.cloud_function_src_bucket.name
#   depends_on = [
#     google_storage_bucket.cloud_function_src_bucket
#   ]
}



