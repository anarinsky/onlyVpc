resource "aws_security_group" "dataase" {
  name = format("tf-%s-%s-dataase", var.project_name, local.current_env)

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = local.db_port
    protocol  = "tcp"
    to_port   = local.db_port
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    local.default_tags,
    {
      Name = format("tf-%s-%s-dataase", var.project_name, local.current_env)
    }
  )
}