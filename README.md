# terraform-google-dataflow-splunk

Terraform module for setup of GCP logging to Splunk using Dataflow.

## Requirements

- A Splunk environment with a public HEC endpoint and token

## Configuration

### Required input variables
- `gcp_region` - The GCP region where you want Dataflow running (ex. `europe-west1`)
- `gcp_zone` - The GCP zone where you want Dataflow running (ex. `europe-west1-b`)
- `gcp_log_project` - The GCP project where you want Dataflow running (ex. `my-logging-project`)
- `splunk_hec_url` - The HEC endpoint URL for Dataflow to use (ex. `https://splunk.example.com:8088`)
- `splunk_hec_token` - The HEC token for Dataflow to use (ex. `5fbfabb9-f788-4b0c-8af3-18584776f9c3`)

### Optional input variables
(see description in `variables.tf`)

### Log Sinks

Included in the module:
- Organization Log Sink
- Project Log Sink

Both are disabled by default and include a catch-all filter that will include all logs in the organization/project, but discard the Dataflow job logs.

Enable the Log Sinks by setting `log_sink_org_enable` or `log_sink_proj_enable` to `1` and including `log_sink_org_id` or `log_sink_proj_name`. See example usage below.

## Example usage

```
module "dataflow-splunk" {
  source = "lindeskar/dataflow-splunk/google"
  version = "0.0.2"

  gcp_region                         = "europe-west1"
  gcp_zone                           = "europe-west1-b"
  gcp_log_project                    = "my-logging-project"

  log_sink_org_enable                = 1
  log_sink_org_id                    = "123456789012"
  log_sink_proj_enable               = 0
  log_sink_proj_name                 = "my-primary-project"

  splunk_hec_url                     = "https://splunk.example.com:8088"
  splunk_hec_token                   = "5fbfabb9-f788-4b0c-8af3-18584776f9c3"
}
```
