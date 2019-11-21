output "vpc_id" {
  value = "${alicloud_vpc.vpc.0.id}"
}

output "vpc_cidr_block" {
  value = "${alicloud_vpc.vpc.0.cidr_block}"
}

output "vswitch_ids" {
  value = "${alicloud_vswitch.vswitch.*.id}"
}

output "availability_zones" {
  value = "${alicloud_vswitch.vswitch.*.availability_zone}"
}

