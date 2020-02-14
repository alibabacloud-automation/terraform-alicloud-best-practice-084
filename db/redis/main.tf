//https://www.terraform.io/docs/providers/alicloud/r/kvstore_instance.html
resource "alicloud_kvstore_instance" "default" {
  count                = "${var.use_redis_module ? var.instance_count : 0}"
  availability_zone    = "${var.zone_id}"
  instance_charge_type = "${var.instance_charge_type}"
  instance_class       = "${var.instance_class}"
  instance_name        = "${var.instance_name}"
  vswitch_id           = "${var.vswitch_id}"
  security_ips         = "${var.security_ips}"
  instance_type        = "${var.instance_type}"
  engine_version       = "${var.engine_version}"
}

resource "alicloud_kvstore_account" "account" {
  count           = "${var.use_redis_module ? (var.create_app_account?  1:0 ) : 0}"
  instance_id      = "${element(alicloud_kvstore_instance.default.*.id, count.index)}"
  account_name     = "${var.account_name}"
  account_password = "${var.account_password}"
  account_privilege = "${var.account_privilege}"
}

resource "alicloud_kvstore_backup_policy" "default" {
  count         = "${var.use_redis_module ? 1 : 0}"
  instance_id   = "${element(alicloud_kvstore_instance.default.*.id, count.index)}"
  backup_period = "${var.backup_period}"
  backup_time   = "${var.backup_time}"
}