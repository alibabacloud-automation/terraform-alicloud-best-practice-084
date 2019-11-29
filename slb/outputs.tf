output "slb_id" {
  value = "${data.alicloud_slbs.slb.slbs.0.id}"
}

output "slb_address" {
  value = "${data.alicloud_slbs.slb.slbs.0.address}"
}


