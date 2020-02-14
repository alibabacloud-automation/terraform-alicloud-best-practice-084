// https://www.terraform.io/docs/providers/alicloud/r/mongodb_instance.html
resource "alicloud_mongodb_instance" "default" {
  count                = "${var.use_mongodb_module ? var.instance_count : 0}"
  instance_charge_type = "${var.instance_charge_type}"
  zone_id              = "${var.zone_id}"
  vswitch_id           = "${var.vswitch_id}"
  security_ip_list     = "${var.security_ips}"

  engine_version      = "${var.engine_version}"
  db_instance_class   = "${var.db_instance_class}"
  db_instance_storage = "${var.db_instance_storage}"

  name = "${var.instance_name}"
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
