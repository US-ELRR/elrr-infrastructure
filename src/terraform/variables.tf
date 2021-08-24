variable "agent1_ec2" {
  type = string
  default = "elrr_agent1"
}

variable "agent2_ec2" {
  type = string
  default = "elrr_agent2"
}

variable "agent3_ec2" {
  type = string
  default = "elrr_agent3"
}

variable "agent4_ec2" {
  type = string
  default = "elrr_agent4"
}

variable "auth_ec2" {
  type = string
  default = "elrr_auth"
}

variable "kafka_ec2" {
  type = string
  default = "elrr_kafka"
}

variable "zookeeper_ec2" {
  type = string
  default = "elrr_zookeeper"
}

variable "local_staging_ec2" {
  type = string
  default = "elrr_local_staging"
}

variable "portal_ec2" {
  type = string
  default = "elrr_portal"
}

variable "storage_ec2" {
  type = string
  default = "elrr_storage"
}

variable "xapi_gateway_ec2" {
  type = string
  default = "elrr_xapi_gateway"
}
