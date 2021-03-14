locals {
  db_identifier              = "${lower(var.project_name)}-${local.current_env}"
  db_engine                  = "mariadb"
  db_engine_major_version    = "10.3"
  db_engine_version          = "10.3.23"
  db_instance_class          = "db.t3.small"
  db_allocated_storage       = "5"
  db_storage_encrypted       = true
  db_port                    = 3306
  db_username                = var.database_username
  db_password                = var.database_password
  db_maintenance_window      = "Tue:00:00-Tue:03:00"
  db_backup_window           = "03:00-06:00"
  db_backup_retention_period = 5
}

module "db-subnet-group" {
  source = "./modules/rds/db_subnet_group_v12"

  identifier  = local.db_identifier
  name_prefix = local.db_identifier
  # subnet_ids  = module.vpc.database_subnets
  subnet_ids  = module.vpc.public_subnets
}

module "database" {
  source = "./modules/rds/db_instance_v12"

  identifier = local.db_identifier

  engine                 = local.db_engine
  engine_version         = local.db_engine_version
  instance_class         = local.db_instance_class
  allocated_storage      = local.db_allocated_storage
  storage_encrypted      = local.db_storage_encrypted
  publicly_accessible    = "true"
  # publicly_accessible    = "false"
  apply_immediately      = "true"
  monitoring_role_name   = "${lower(var.project_name)}-${local.current_env}"
  monitoring_interval    = 60
  create_monitoring_role = true
  option_group_name      = aws_db_option_group.database-option-group.name
  enabled_cloudwatch_logs_exports = [
    "audit",
  ]

  username = local.db_username
  password = local.db_password
  port     = local.db_port

  vpc_security_group_ids = [
    aws_security_group.dataase.id,
  ]

  db_subnet_group_name = module.db-subnet-group.this_db_subnet_group_id

  maintenance_window = local.db_maintenance_window
  backup_window      = local.db_backup_window

  performance_insights_enabled = false

  # disable backups to create DB faster
  backup_retention_period = local.db_backup_retention_period

  tags = local.default_tags
}

