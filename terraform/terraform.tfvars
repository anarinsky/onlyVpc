region       = "us-east-1"
project_name = "db-monitoring-prototype"
env_name     = "development"

cidr             = "10.110.0.0/16"
private_subnets  = ["10.110.1.0/24", "10.110.2.0/24", "10.110.3.0/24"]
public_subnets   = ["10.110.101.0/24", "10.110.102.0/24", "10.110.103.0/24"]
