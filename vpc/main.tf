resource "alicloud_vpc" "vpc" {
  count = "${var.use_vpc_module ? 1 : 0}"
  name       = "${var.vpc_name}"
  cidr_block = "${var.vpc_cidr}"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id            = "${alicloud_vpc.vpc.0.id}"
  count             = "${var.use_vpc_module ? length(var.cidr_blocks) : 0}"
  cidr_block        = "${lookup(var.cidr_blocks, "az${count.index}")}"
  availability_zone = "${lookup(var.availability_zones,"az${count.index}")}"
}


