variable "use_redis_module" {}
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
  default = "redis.master.small.default"
}

variable "instance_type" {
  default = "Redis"
}

variable "engine_version" {
  default = "4.0"
}

#################
# Account
#################
variable "create_app_account" {
  description = "Whether to create multiple databases. If true, the `databases` should not be empty."
  default     = true
}
variable "account_name" {}
variable "account_password" {}
variable "account_privilege" {
  description = "The privilege of one account access database."
  default     = "RoleReadOnly"
}


#################
# Backup policy
#################
variable "backup_time" {
  description = "DB Instance backup period."
  default     = "02:00Z-03:00Z"
}
variable "backup_period" {
  description = " DB instance backup time, in the format of HH:mmZ- HH:mmZ. "
  default     = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}
