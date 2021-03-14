output "database_username" {
  value = module.database.this_db_instance_username
}

output "database_password" {
  value = module.database.this_db_instance_password
}

output "database_name" {
  value = var.database_name
}

output "endpoint" {
  value = module.database.this_db_instance_endpoint
}
