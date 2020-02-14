variable "use_rds4mysql_module" {}

#################
# Instance
#################

variable "instance_charge_type" {
  description = "The instance charge type. Valid values: Prepaid and Postpaid. Default to Postpaid."
  default     = "Postpaid"
}

variable "instance_count" {
  default = 1
}
variable "tags" {
  description = "A mapping of tags to assign to the instance."
  default     = {}
}


variable "zone_id" {}
variable "vswitch_id" {}
variable "security_ips" {}
variable "instance_name" {}

variable "instance_type" {
  default = "rds.mysql.s3.large"
}
variable "engine" {
  default = "MySQL"
}
variable "engine_version" {
  default = "5.6"
}

variable "instance_storage" {
  description = "The storage capacity of the instance. Unit: GB. The storage capacity increases at increments of 5 GB. For more information, see [Instance Types](https://www.alibabacloud.com/help/doc-detail/26312.htm)."
  default     = 20
}


#################
# Connection
#################
variable "port" {
  description = " Internet connection port. Valid value: [3001-3999]. Default to 3306."
  default     = 3306
}

variable "connection_prefix" {
  description = "Prefix of an Internet connection string. A random name prefixed with 'tf-rds-' will be set if it is empty."
  default     = ""
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
variable "backup_retention_period" {
  description = "Instance backup retention days. Valid values: [7-730]. Default to 7."
  default     = 7
}
variable "enable_backup_log" {
  description = "Whether to backup instance log. Default to true."
  default     = true
}
variable "log_backup_retention_period" {
  description = "Instance log backup retention days. Valid values: [7-730]. Default to 7. It can be larger than 'retention_period'."
  default     = 7
}

#################
# ReadWrite Splitting
#################
variable "rw_spliting_enable" {
  default = true
}

variable "ro_instance_count" {
  default = 2
}

variable "rw_connection_prefix" {
  description = "Prefix of an Internet connection string. It must be checked for uniqueness. It may consist of lowercase letters, numbers, and underlines, and must start with a letter and have no more than 30 characters."
  default     = "terraform_rw"
}

variable "distribution_type" {
  description = "Read weight distribution mode. Values are as follows: Standard indicates automatic weight distribution based on types, Custom indicates custom weight distribution."
  default     = "Standard"
}