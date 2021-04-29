
# Required input variables

variable "gcp_region" {
  description = "The GCP region where you want Dataflow running (e.g. europe-west1)"
  type    = string
}

variable "gcp_zone" {
  description = "The GCP zone where you want Dataflow running (e.g. europe-west1-b)"
  type    = string
}
variable "gcp_log_project" {
  description = "The GCP project where you want Dataflow running (e.g. my-logging-project)"
  type    = string
}

variable "splunk_hec_url" {
  description = "The HEC endpoint URL for Dataflow to use (e.g. https://splunk.example.com:8088)"
  type    = string
}

variable "splunk_hec_token" {
  description = "The HEC token for Dataflow to use (e.g. 5fbfabb9-f788-4b0c-8af3-18584776f9c3)"
  type    = string
}

# Optional input variables

variable "log_sink_org_enable" {
  description = "Enable (1) or disable (0) the organization Log Sink"
  type    = number
  default = 0
}

variable "log_sink_org_id" {
  description = "The GCP organization ID that you want Splunk to receive logs from (e.g. 123456789012)"
  type    = string
  default = ""
}

variable "log_sink_proj_enable" {
  description = "Enable (1) or disable (0) the organization Log Sink"
  type    = number
  default = 0
}

variable "log_sink_proj_name" {
  description = "The GCP project that you want Splunk to receive logs from (e.g. my-primary-project)"
  type    = string
  default = ""
}

variable "dataflow_base_name" {
  description = "A base name for the objects to create for Dataflow (e.g. splunk-dataflow)"
  type    = string
  default = "dataflow-splunk"
}

variable "dataflow_max_workers" {
  description = "Number of maximum Dataflow workers"
  type    = number
  default = 1
}

variable "dataflow_job_enable" {
  description = "Enable (1) or disable (0) the Dataflow job"
  type    = number
  default = 1
}

variable "dataflow_worker_machine_type" {
  description = "Machine type for the Dataflow workers (e.g. e2-medium)"
  type    = string
  default = "e2-medium"
}

variable "splunk_hec_disable_cert_validation" {
  description = "Disable (true) or enable (false) certificate validation of the HEC endpoint"
  type    = string
  default = "false"
}

variable "dataflow_batchCount" {
  description = "The batchCount to use with Dataflow"
  type    = number
  default = 10
}

variable "dataflow_parallelism" {
  description = "The parallelism to use with Dataflow"
  type    = number
  default = 4
}

variable "pubsub_msg_retention" {
  description = "Retention time for Pub/Sub messages"
  type    = string
  default = "1200s"
}
