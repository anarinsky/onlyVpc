resource "aws_db_option_group" "database-option-group" {
  name                     = "option-group-${lower(var.project_name)}-${local.current_env}"
  option_group_description = "Terraform Option Group"
  engine_name              = local.db_engine
  major_engine_version     = local.db_engine_major_version

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"

    option_settings {
      name  = "SERVER_AUDIT_FILE_ROTATIONS"
      value = "50"
    }

    option_settings {
      name  = "SERVER_AUDIT_EVENTS"
      value = "CONNECT,QUERY"
    }

    option_settings {
      name  = "SERVER_AUDIT_QUERY_LOG_LIMIT"
      value = "2147483647"
    }
  }
}
