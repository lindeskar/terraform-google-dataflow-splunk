# terraform-google-dataflow-splunk

Terraform module for setup of GCP logging to Splunk using Dataflow.

## Example usage

```
module "dataflow-splunk" {
  source = "lindeskar/dataflow-splunk/google"

  gcp_region                         = "europe-west1"
  gcp_zone                           = "europe-west1-b"
  gcp_log_project                    = "my-primary-project"
  log_sink_org_id                    = "123456789012"
  log_sink_org_filter_projects       = ["my-primary-project", "my-secondary-project"]
  dataflow_base_name                 = "splunk-dataflow"
  dataflow_max_workers               = 1
  dataflow_enable                    = 1
  dataflow_worker_machine_type       = "e2-medium"
  splunk_hec_url                     = "https://splunk.example.com:8088"
  splunk_hec_token                   = "5fbfabb9-f788-4b0c-8af3-18584776f9c3"
  splunk_hec_disable_cert_validation = "false"
}
```

## Requirements

- A Splunk environment with a public HEC endpoint and token
