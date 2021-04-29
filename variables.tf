variable "gcp_region" {
  description = "The GCP region where you want Dataflow running (ex. europe-west1)"
}
variable "gcp_zone" {
  description = "The GCP zone where you want Dataflow running (ex. europe-west1-b)"
}
variable "gcp_log_project" {
  description = "The GCP project where you want Dataflow running (ex. my-primary-project)"
}
variable "log_sink_org_id" {
  description = "The GCP organization ID that you want Dataflow to monitor (ex. 123456789012)"
  type    = string
  default = ""
}
variable "log_sink_org_filter_projects" {
  description = "A list of project names to use in the organization Log Sink filter (ex. ['my-primary-project', 'my-secondary-project'])"
  type    = list(string)
  default = []
}
variable "dataflow_base_name" {
  description = "A base name for the objects to create for Dataflow (ex. splunk-dataflow)"
}
variable "dataflow_max_workers" {
  description = "Number of maximum Dataflow workers"
  type    = number
  default = 1
}
variable "dataflow_enable" {
  description = "Enable (1) or disable (0) Dataflow"
  type    = number
  default = 1
}
variable "dataflow_worker_machine_type" {
  description = "Machine type for the Dataflow workers (ex. e2-medium)"
  type    = string
  default = null
}
variable "splunk_hec_url" {
  description = "The HEC endpoint URL for Dataflow to use (ex. https://splunk.example.com:8088)"
}
variable "splunk_hec_token" {
  description = "The HEC token for Dataflow to use (ex. 5fbfabb9-f788-4b0c-8af3-18584776f9c3)"
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
