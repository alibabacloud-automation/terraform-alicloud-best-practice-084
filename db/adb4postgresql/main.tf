// https://www.terraform.io/docs/providers/alicloud/r/mongodb_instance.html
resource "alicloud_gpdb_instance" "default" {
  count                = "${var.use_adb4postgresql_module ? var.instance_count : 0}"
  instance_charge_type = "${var.instance_charge_type}"
  zone_id              = "${var.zone_id}"
  vswitch_id           = "${var.vswitch_id}"
  security_ip_list     = "${var.security_ips}"
  description          = "${var.instance_name}"

  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.instance_class}"
  instance_group_count = "${var.instance_group_count}"

}
