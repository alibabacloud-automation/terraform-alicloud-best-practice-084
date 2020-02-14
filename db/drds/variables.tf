variable "use_drds_module" {}
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
# variable "security_ips" {}
variable "instance_name" {}

variable "instance_series" {
  default = "drds.sn1.4c8g"
}

variable "specification" {
  default = "drds.sn1.4c8g.8C16G"
}
