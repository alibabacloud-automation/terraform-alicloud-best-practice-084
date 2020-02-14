#RDS
resource "alicloud_db_instance" "rds" {
  count = "${var.use_rds_module ? var.rds_count : 0}"
  instance_name = "${var.rds_name}-${format(var.count_format, count.index+1)}"
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_type = "${var.instance_type}"
  instance_storage = "${var.instance_storage}"
  instance_charge_type = "${var.instance_charge_type}"
  zone_id = "${var.rds_zone_id}"
  vswitch_id = "${var.vswitch_id}"
  security_ips = ["${var.vpc_cidr_block}"]
  tags = "${var.tags}"
}

resource "alicloud_db_account" "account" {
  count = "${var.use_rds_module ? var.rds_count : 0}"
  instance_id = "${element(alicloud_db_instance.rds.*.id,count.index)}"
  name = "${var.rds_account_name}"
  password = "${var.rds_account_pwd}"
  type = "${var.account_type}"
}

resource "alicloud_db_database" "db" {
  count = "${var.use_rds_module ? var.rds_count : 0}"
  instance_id = "${element(alicloud_db_instance.rds.*.id,count.index)}"
  name = "${var.account_name}"
  character_set = "${var.character_set}"
  description = "${var.db_description}"
}

//高权限账号不需要授权，如果普通账号请打开
resource "alicloud_db_account_privilege" "privilege" {
  count = "${var.account_type != "Super"  ? (var.use_rds_module ? var.rds_count : 0) : 0}"
  instance_id = "${element(alicloud_db_instance.rds.*.id,count.index)}"
  account_name = "${element(alicloud_db_account.account.*.name,count.index)}"
  privilege = "${var.account_privilege}"
  db_names = "${alicloud_db_database.db.*.name}"
}
