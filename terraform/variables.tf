variable "region" {}
variable "project_name" {}
variable "env_name" {}

variable "cidr" {}
variable "private_subnets" {
  default = []
  type    = list
}
variable "public_subnets" {
  default = []
  type    = list
}
