resource "alicloud_eip" "eip" {
  count = "${var.use_eip_module ? 1 :0}"
  bandwidth            = "${var.bandwidth}"
  internet_charge_type = "${var.eip_internet_charge_type}"
  isp = "${var.isp}"
  instance_charge_type = "${var.eip_instance_charge_type}"
}


resource "alicloud_eip_association" "eip_asso" {
  count = "${var.use_eip_module ? 1 :0}"
  allocation_id = "${alicloud_eip.eip.0.id}"
  instance_id   = "${var.instance_id}"
}

