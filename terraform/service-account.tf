data "google_storage_project_service_account" "gcs_account" {
}

resource "google_project_iam_member" "gcs-pubsub-publishing" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

resource "google_service_account" "sa" {
  account_id   = "cloud-function-service-account"
  display_name = "A service account for a cloud function that allows access to a bucket"
}

resource "google_cloudfunctions2_function_iam_member" "invoker" {
  project        = var.project_id
  location       = var.region
  cloud_function = var.function_name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${google_service_account.sa.email}"
  depends_on = [ google_cloudfunctions2_function.cloud_function ]
}

resource "google_cloud_run_service_iam_member" "cloud_run_invoker" {
  project  = var.project_id
  location = var.region
  service  = var.function_name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.sa.email}"
  depends_on = [ google_cloudfunctions2_function.cloud_function ]
}

resource "google_project_iam_member" "invoking" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.sa.email}"
  depends_on = [google_project_iam_member.gcs-pubsub-publishing]
}

resource "google_project_iam_member" "event-receiving" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.sa.email}"
  depends_on = [google_project_iam_member.invoking]
}

resource "google_project_iam_member" "artifactregistry-reader" {
  project = var.project_id
  role     = "roles/artifactregistry.reader"
  member   = "serviceAccount:${google_service_account.sa.email}"
  depends_on = [google_project_iam_member.event-receiving]
}