variable "gcp_region" {
  description = ""
}
variable "gcp_zone" {
  description = ""
}
variable "gcp_log_project" {
  description = ""
}
variable "log_sink_org_id" {
  description = ""
  type    = string
  default = ""
}
variable "log_sink_org_filter_projects" {
  description = ""
  type    = list(string)
  default = []
}
variable "dataflow_base_name" {
  description = ""
}
variable "dataflow_max_workers" {
  description = ""
  type    = number
  default = null
}
variable "dataflow_enable" {
  description = ""
  type    = number
  default = 1
}
variable "dataflow_worker_machine_type" {
  description = ""
  type    = string
  default = null
}
variable "splunk_hec_url" {
  description = ""
}
variable "splunk_hec_token" {
  description = ""
}
variable "splunk_hec_disable_cert_validation" {
  description = ""
  type    = string
  default = "false"
}
variable "dataflow_batchCount" {
  description = ""
  type    = number
  default = 10
}
variable "dataflow_parallelism" {
  description = ""
  type    = number
  default = 4
}
