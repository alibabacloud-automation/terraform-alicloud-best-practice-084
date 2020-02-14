output "ids" {
  value = "${alicloud_kvstore_instance.default.*.id}"
}
output "connection_domain" {
  value = "${alicloud_kvstore_instance.default.*.connection_domain}"
}