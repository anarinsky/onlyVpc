region       = "us-east-1"
project_name = "db-monitoring-prototype"
env_name     = "development"

cidr             = "10.110.0.0/16"
private_subnets  = ["10.110.1.0/24", "10.110.2.0/24", "10.110.3.0/24"]
public_subnets   = ["10.110.101.0/24", "10.110.102.0/24", "10.110.103.0/24"]
database_subnets = ["10.110.201.0/24", "10.110.202.0/24", "10.110.203.0/24"]


database_username = "testuser21"
database_password = "kmKQIbW7rl447pFxGglfDG4OsOm36b81vTj8BuoJr"
database_name = "testdb"
