output "ids" {
  value = "${alicloud_drds_instance.default.*.id}"
}