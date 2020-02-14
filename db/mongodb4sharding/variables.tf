variable "use_mongodb4sharding_module" {}
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

variable "db_instance_class" {
  default = "dds.mongo.mid"
}

variable "db_instance_storage" {
  default = "100"
}

variable "engine_version" {
  default = "4.0"
}

variable "mongo_list" {
  default = {}
}

variable "shard_list" {
  default = {}
}

#################
# Account
#################
variable "root_password" {}

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
