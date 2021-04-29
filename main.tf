
# Pub/Sub topics

resource "google_pubsub_topic" "log-topic" {
  name    = "${var.dataflow_base_name}-log-topic"
  project = var.gcp_log_project
}

resource "google_pubsub_topic" "log-dl-topic" {
  name    = "${var.dataflow_base_name}-log-dl-topic"
  project = var.gcp_log_project
}


# Pub/Sub subscriptions

resource "google_pubsub_subscription" "log-sub" {
  name    = "${var.dataflow_base_name}-log-sub"
  project = var.gcp_log_project
  topic   = google_pubsub_topic.log-topic.name

  message_retention_duration = "1200s"
}

resource "google_pubsub_subscription" "log-dl-sub" {
  name    = "${var.dataflow_base_name}-log-dl-sub"
  project = var.gcp_log_project
  topic   = google_pubsub_topic.log-dl-topic.name

  message_retention_duration = "1200s"
}


# Log sinks

resource "google_logging_organization_sink" "log-org-sink" {
  name  = "${var.dataflow_base_name}-log-org-sink"
  count = var.log_sink_org_id == "" ? 0 : 1

  org_id           = var.log_sink_org_id
  include_children = true
  filter = templatefile("${path.module}/dataflow-sink-filter-catchall.tpl", {
    org_id         = var.log_sink_org_id,
    log_project    = var.gcp_log_project,
    extra_projects = var.log_sink_org_filter_projects,
    dataflow_name  = var.dataflow_enable == 1 ? google_dataflow_job.splunk-job[0].name : ""
  })

  destination = "pubsub.googleapis.com/${google_pubsub_topic.log-topic.id}"
}

## Add project log sink ?


# Pub/Sub topic IAM policy

resource "google_pubsub_topic_iam_member" "log-topic-sink-member" {
  project = google_pubsub_topic.log-topic.project
  topic   = google_pubsub_topic.log-topic.name
  role    = "roles/pubsub.publisher"
  member  = google_logging_organization_sink.log-org-sink.0.writer_identity
}


# Bucket for temp storage

resource "google_storage_bucket" "log-bucket" {
  name                        = "${var.dataflow_base_name}-log-bucket"
  project                     = var.gcp_log_project
  location                    = var.gcp_region
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "temp" {
  name       = "${var.dataflow_base_name}/temp/.ignore"
  content    = "IGNORE"
  bucket     = google_storage_bucket.log-bucket.name
  depends_on = [google_storage_bucket.log-bucket]
}

resource "google_storage_bucket_object" "splunk-udf" {
  name = "${var.dataflow_base_name}/js/splunk-udf.js"
  content = templatefile("${path.module}/dataflow-udf-js.tpl", {
    input_sub = google_pubsub_subscription.log-sub.name
  })
  bucket     = google_storage_bucket.log-bucket.name
  depends_on = [google_storage_bucket.log-bucket]
}


# Dataflow
resource "google_dataflow_job" "splunk-job" {
  name         = "${var.dataflow_base_name}-splunk-job"
  count        = var.dataflow_enable == 1 ? 1 : 0
  project      = var.gcp_log_project
  region       = var.gcp_region
  zone         = var.gcp_zone
  machine_type = var.dataflow_worker_machine_type
  max_workers  = var.dataflow_max_workers

  template_gcs_path = "gs://dataflow-templates-${var.gcp_region}/latest/Cloud_PubSub_to_Splunk"

  temp_gcs_location = "${google_storage_bucket.log-bucket.url}/${dirname(google_storage_bucket_object.temp.name)}"

  parameters = {
    inputSubscription                   = google_pubsub_subscription.log-sub.id
    outputDeadletterTopic               = google_pubsub_topic.log-dl-topic.id
    url                                 = var.splunk_hec_url
    token                               = var.splunk_hec_token
    javascriptTextTransformGcsPath      = "${google_storage_bucket.log-bucket.url}/${google_storage_bucket_object.splunk-udf.name}"
    javascriptTextTransformFunctionName = "transform"
    disableCertificateValidation        = var.splunk_hec_disable_cert_validation
    batchCount                          = var.dataflow_batchCount,
    parallelism                         = var.dataflow_parallelism
  }

  on_delete = "cancel"
}
