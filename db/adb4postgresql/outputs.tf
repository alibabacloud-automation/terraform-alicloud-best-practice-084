output "ids" {
  value = "${alicloud_gpdb_instance.default.*.id}"
}