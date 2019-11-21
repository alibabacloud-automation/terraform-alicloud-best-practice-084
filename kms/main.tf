resource "alicloud_kms_key" "key" {
  count = "${var.use_kms_module ? 1 : 0}"
  description             = "${var.description}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  is_enabled              = "${var.is_enabled}"
}