output "kms_id" {
  value = "${alicloud_kms_key.key.*.id}"
}

output "kms_key_usage" {
  value = "${alicloud_kms_key.key.*.key_usage}"
}

output "kms_deletion_window_in_days" {
  value = "${alicloud_kms_key.key.*.deletion_window_in_days}"
}

output "kms_is_enabled" {
  value = "${alicloud_kms_key.key.*.is_enabled}"
}