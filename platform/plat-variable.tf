#variable for platform resouces
variable "region" {
  default     = "eu-west-2"
  description = "ecs region"
}

variable "remote_state_key" {}
variable "remote_state_bucket" {}
variable "ecs_cluster_name" {}
variable "ecs_domain_name" {}
variable "internet_cidr_block" {}
