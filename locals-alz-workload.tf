locals {
  alz_workload_settings_json           = tostring(jsonencode(var.alz_workload_settings))
  alz_workload_settings_json_templated = templatestring(local.alz_workload_settings_json, local.config_template_file_variables)
  alz_workload_settings_json_final     = replace(replace(local.alz_workload_settings_json_templated, "\"[", "["), "]\"", "]")
  alz_workload_settings                = jsondecode(local.alz_workload_settings_json_final)
}
