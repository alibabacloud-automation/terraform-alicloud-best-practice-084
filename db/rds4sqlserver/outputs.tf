output "ids" {
  value = "${alicloud_db_instance.this.*.id}"
}

output "ports" {
  value = "${alicloud_db_instance.this.*.port}"
}

output "connection_strings" {
  value = "${alicloud_db_instance.this.*.connection_string}"
}