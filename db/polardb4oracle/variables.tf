variable "use_polardb4oracle_module" {}
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

variable "instance_node_class" {
  default = "polar.o.x4.medium"
}

variable "engine" {
  default = "Oracle"
}

variable "engine_version" {
  default = "11"
}

#################
# Database
#################
variable "create_database" {
  description = "Whether to create multiple databases. If true, the `databases` should not be empty."
  default     = true
}
variable "databases" {
  description = "A list mapping used to add multiple databases. Each item supports keys: name, character_set and description. It should be set when create_database = true."
  default     = []
}


#################
# Database Account
#################
variable "create_super_account" {
  description = "Whether to create multiple databases. If true, the `databases` should not be empty."
  default     = false
}
variable "account_super_name" {}
variable "account_super_pwd" {}
variable "account_super_type" {
  default = "Super"
}
variable "create_app_account" {
  description = "Whether to create multiple databases. If true, the `databases` should not be empty."
  default     = true
}
variable "account_app_name" {}
variable "account_app_pwd" {}
variable "account_app_privilege" {
  description = "The privilege of one account access database."
  default     = "ReadOnly"
}


#################
# Backup policy
#################
variable "preferred_backup_period" {
  description = "DB Instance backup period."
  default     = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}
variable "preferred_backup_time" {
  description = " DB instance backup time, in the format of HH:mmZ- HH:mmZ. "
  default     = "02:00Z-03:00Z"
}