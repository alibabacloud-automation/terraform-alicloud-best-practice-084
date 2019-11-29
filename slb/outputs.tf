output "slb_id" {
  value = "${data.alicloud_slbs.slb.ids[0]}"
}

output "slb_address" {
  value = "${data.alicloud_slbs.slb.slbs.0.address}"
}


