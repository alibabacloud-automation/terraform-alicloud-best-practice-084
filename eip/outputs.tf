output "eip_id" {
  value = "${alicloud_eip.eip.*.id}"
}

output "eip_bandwidth" {
  value = "${alicloud_eip.eip.*.bandwidth}"
}

output "eip_internet_charge_type" {
  value = "${alicloud_eip.eip.*.internet_charge_type}"
}

output "eip_status" {
  value = "${alicloud_eip.eip.*.status}"
}

output "eip_ip_address" {
  value = "${alicloud_eip.eip.*.ip_address}"
}