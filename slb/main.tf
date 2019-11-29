resource "alicloud_slb" "slb" {
  count = "${var.use_slb_module ? 1 : 0}"
  name = "${var.slb_name}"
  address_type = "${var.address_type}"
  specification = "${var.specification}"
  master_zone_id = "${var.master_zone_id}"
  slave_zone_id = "${var.slave_zone_id}"
  delete_protection = "${var.delete_protection}"
  internet_charge_type = "${var.internet_charge_type}"
  vswitch_id = "${var.vswitch_id}"
  tags = "${var.tags}"
}

data "alicloud_slbs" "slb" {
  tags = "${var.tags}"
  depends_on = ["alicloud_slb.slb"]
}

resource "alicloud_slb_attachment" "default" {
  count = "${var.use_slb_module ? 1 : 0 }"
  load_balancer_id    = "${data.alicloud_slbs.slb.ids[0]}"
  instance_ids = "${var.instance_ids}"
}

resource "alicloud_slb_listener" "http" {
  count = "${var.use_slb_module ? 1 : 0 }"
  load_balancer_id = "${data.alicloud_slbs.slb.ids[0]}"
  backend_port = 80
  frontend_port = 80
  bandwidth = -1
  protocol = "http"
  sticky_session = "on"
  sticky_session_type = "insert"
  cookie = "testslblistenercookie"
  cookie_timeout = 10000
  health_check = "on"
  health_check_connect_port = 80
  health_check_http_code = "http_2xx,http_3xx"
}


