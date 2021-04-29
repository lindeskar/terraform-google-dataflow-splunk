logName:"organizations/" OR logName:"folders/" OR logName:"projects/" NOT (resource.type = "dataflow_step" AND resource.labels.job_name = "${dataflow_name}")
