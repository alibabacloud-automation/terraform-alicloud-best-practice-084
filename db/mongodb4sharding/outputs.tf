output "ids" {
  value = "${alicloud_mongodb_instance.default.*.id}"
}