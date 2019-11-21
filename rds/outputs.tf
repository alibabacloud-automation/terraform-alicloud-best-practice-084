output "rds_ids" {
  value = "${alicloud_db_instance.rds.*.id}"
}

output "rds_ports" {
  value = "${alicloud_db_instance.rds.*.port}"
}

output "rds_connection_strings" {
  value = "${alicloud_db_instance.rds.*.connection_string}"
}