
//https://www.terraform.io/docs/providers/alicloud/r/mongodb_sharding_instance.html

resource "alicloud_mongodb_sharding_instance" "default" {
  count                = "${var.use_redis_module ? var.instance_count : 0}"
  instance_charge_type = "${var.instance_charge_type}"
  vswitch_id           = "${var.vswitch_id}"
  name                 = "${var.instance_name}"
  security_ip_list     = "${var.security_ips}"
  engine_version       = "${var.engine_version}"
  db_instance_class    = "${var.db_instance_class}"
  db_instance_storage  = "${var.db_instance_storage}"
  shard_list           = "${var.shard_list}"
  mongo_list           = "${var.mongo_list}"
  #################
  #  Account
  #################
  account_password = "${var.root_password}"

  #################
  #  Backup Policy
  #################
  backup_time   = "${var.backup_time}"
  backup_period = "${var.backup_period}"
}
