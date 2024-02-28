# Create the Cloud function triggered by a `Finalize` event on the bucket
resource "google_cloudfunctions2_function" "cloud_function" {
  name                  = var.function_name
  description           = "Cloud-function will get trigger once file is uploaded in input-${var.project_id}"
  location = var.region

  service_config {
    max_instance_count  = 1
    available_memory    = "256M"
    timeout_seconds     = 60
    service_account_email = google_service_account.sa.email
  }

  build_config {
    runtime               = "python311"
    entry_point           = "hello_gcs"
    environment_variables = {
      GOOGLE_FUNCTION_SOURCE = "${local.filename}/main.py"
    }
    source {
      storage_source {
        bucket = google_storage_bucket.cloud_function_src_bucket.name
        object = "${local.filenameext}"
      }
    }
  }
#   vpc_connector tbd
  event_trigger {
    event_type = "google.cloud.storage.object.v1.finalized"
    retry_policy = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.sa.email
    event_filters {
      attribute = "bucket"
      value = google_storage_bucket.input_bucket.name
    }
  }
  depends_on = [
    google_storage_bucket_object.zip,
    google_project_iam_member.event-receiving,
    google_project_iam_member.artifactregistry-reader,

  ]
}