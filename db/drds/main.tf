// https://www.terraform.io/docs/providers/alicloud/r/mongodb_instance.html
resource "alicloud_drds_instance" "default" {
  count                = "${var.use_drds_module ? var.instance_count : 0}"
  instance_charge_type = "${var.instance_charge_type}"
  zone_id              = "${var.zone_id}"
  vswitch_id           = "${var.vswitch_id}"
  description          = "${var.instance_name}"
  instance_series      = "${var.instance_series}"
  specification        = "${var.specification}"

}
