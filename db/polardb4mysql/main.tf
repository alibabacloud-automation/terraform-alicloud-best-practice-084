// https://www.terraform.io/docs/providers/alicloud/r/polardb_cluster.html
resource "alicloud_polardb_cluster" "default" {
  count        = "${var.use_polardb4mysql_module ? var.instance_count : 0}"
  pay_type     = "${var.instance_charge_type}"
  zone_id      = "${var.zone_id}"
  vswitch_id   = "${var.vswitch_id}"
  security_ips = "${var.security_ips}"
  description  = "${var.instance_name}"

  db_type       = "${var.engine}"
  db_version    = "${var.engine_version}"
  db_node_class = "${var.instance_node_class}"
}

resource "alicloud_polardb_database" "default" {
  count              = "${var.use_polardb4mysql_module ? (var.create_database ? length(var.databases) : 0) : 0}"
  db_cluster_id      = "${element(alicloud_polardb_cluster.default.*.id, count.index)}"
  db_name            = "${lookup(var.databases[count.index], "name")}"
  character_set_name = "${lookup(var.databases[count.index], "character_set")}"
  db_description     = "${lookup(var.databases[count.index], "description")}"
}

//管理员账号，有super权限
resource "alicloud_polardb_account" "account_manager" {
  count       = "${var.use_polardb4mysql_module ?(var.create_super_account?  1:0 ) : 0}"
  db_cluster_id    = "${element(alicloud_polardb_cluster.default.*.id, count.index)}"
  account_name     = "${var.account_super_name}"
  account_password = "${var.account_super_pwd}"
  account_type     = "${var.account_super_type}"
}

// 应用账号
resource "alicloud_polardb_account" "account_app" {
  count       = "${var.use_polardb4mysql_module ? (var.create_app_account?  1:0 ) : 0}"
  db_cluster_id    = "${element(alicloud_polardb_cluster.default.*.id, count.index)}"
  account_name     = "${var.account_app_name}"
  account_password = "${var.account_app_pwd}"
}

// 应用账号权限设置
resource "alicloud_polardb_account_privilege" "app_privilege" {
  count       = "${var.use_polardb4mysql_module ? (var.create_app_account?  1:0 ) : 0}"
  db_cluster_id     = "${element(alicloud_polardb_cluster.default.*.id, count.index)}"
  account_name      = "${element(alicloud_polardb_account.account_app.*.account_name, count.index)}"
  account_privilege = "${var.account_app_privilege}"
  db_names          = "${alicloud_polardb_database.default.*.db_name}"
}

resource "alicloud_polardb_backup_policy" "default" {
  count                   = "${var.use_polardb4mysql_module ? 1 : 0}"
  db_cluster_id           = "${element(alicloud_polardb_cluster.default.*.id, count.index)}"
  preferred_backup_period = "${var.preferred_backup_period}"
  preferred_backup_time   = "${var.preferred_backup_time}"
}