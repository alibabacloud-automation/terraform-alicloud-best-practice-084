variable "use_adb4postgresql_module" {}
variable "instance_count" {}
#################
# Instance
#################

variable "instance_charge_type" {
  description = "The instance charge type. Valid values: PrePaid and PostPaid. Default to Postpaid."
  default     = "PostPaid"
}

variable "tags" {
  description = "A mapping of tags to assign to the instance."
  default     = {}
}
variable "zone_id" {}
variable "vswitch_id" {}
variable "security_ips" {}
variable "instance_name" {}

variable "instance_class" {
  default = "gpdb.group.segsdx2"
}

variable "instance_group_count" {
  default = 2
}
variable "engine" {
  default = "6.0"
}
variable "engine_version" {
  default = "6.0"
}
