
output "user" {
  value = "${alicloud_ram_user.user.*.id}"
}

output "group" {
  value = "${alicloud_ram_group.group.*.id}"
}
