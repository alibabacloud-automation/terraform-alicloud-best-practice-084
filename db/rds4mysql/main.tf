
// https://www.terraform.io/docs/providers/alicloud/r/db_instance.html
resource "alicloud_db_instance" "this" {
  count                = "${var.use_rds4mysql_module ? var.instance_count : 0}"
  tags                 = "${var.tags}"
  instance_charge_type = "${var.instance_charge_type}"
  zone_id              = "${var.zone_id}"
  vswitch_id           = "${var.vswitch_id}"
  security_ips         = "${var.security_ips}"
  instance_name        = "${var.instance_name}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_type        = "${var.instance_type}"
  instance_storage     = "${var.instance_storage}"
}

resource "alicloud_db_connection" "connn" {
  count         = "${var.use_rds4mysql_module ? (var.connection_prefix!="" ? 1 : 0) : 0}"
  instance_id   = "${element(alicloud_db_instance.this.*.id, count.index)}"
  connection_prefix = "${var.connection_prefix}"
}

resource "alicloud_db_database" "databases" {
  count         = "${var.use_rds4mysql_module ? (var.create_database ? length(var.databases) : 0) : 0}"
  instance_id   = "${element(alicloud_db_instance.this.*.id, count.index)}"
  name          = "${lookup(var.databases[count.index], "name")}"
  character_set = "${lookup(var.databases[count.index], "character_set")}"
  description   = "${lookup(var.databases[count.index], "description")}"
}

//管理员账号，有super权限
resource "alicloud_db_account" "account_manager" {
  count       = "${var.use_rds4mysql_module ?(var.create_super_account?  1:0 ) : 0}"
  instance_id = "${element(alicloud_db_instance.this.*.id, count.index)}"
  name        = "${var.account_super_name}"
  password    = "${var.account_super_pwd}"
  type        = "${var.account_super_type}"
}

// 应用账号
resource "alicloud_db_account" "account_app" {
  count       = "${var.use_rds4mysql_module ? (var.create_app_account?  1:0 ) : 0}"
  instance_id = "${element(alicloud_db_instance.this.*.id, count.index)}"
  name        = "${var.account_app_name}"
  password    = "${var.account_app_pwd}"
}

// 应用账号权限设置
resource "alicloud_db_account_privilege" "app_privilege" {
  count        = "${var.use_rds4mysql_module ? (var.create_app_account?  1:0 ) : 0}"
  instance_id  = "${element(alicloud_db_instance.this.*.id, count.index)}"
  account_name = "${element(alicloud_db_account.account_app.*.name, count.index)}"
  privilege    = "${var.account_app_privilege}"
  db_names     = "${alicloud_db_database.databases.*.name}"
}

resource "alicloud_db_backup_policy" "backup_policy" {
  count                       = "${var.use_rds4mysql_module ? 1 : 0}"
  instance_id                 = "${element(alicloud_db_instance.this.*.id, count.index)}"
  preferred_backup_period     = "${var.preferred_backup_period}"
  preferred_backup_time       = "${var.preferred_backup_time}"
  backup_retention_period     = "${var.backup_retention_period}"
  enable_backup_log           = "${var.enable_backup_log}"
  log_backup_retention_period = "${var.log_backup_retention_period}"
}

resource "alicloud_db_readonly_instance" "default" {
  count                 = "${var.use_rds4mysql_module ?  var.ro_instance_count : 0}"
  master_db_instance_id = "${element(alicloud_db_instance.this.*.id, count.index)}"
  zone_id               = "${element(alicloud_db_instance.this.*.zone_id, count.index)}"
  engine_version        = "${element(alicloud_db_instance.this.*.engine_version, count.index)}"
  instance_type         = "${element(alicloud_db_instance.this.*.instance_type, count.index)}"
  instance_storage      = "${element(alicloud_db_instance.this.*.instance_storage, count.index)}"
  instance_name         = "${element(alicloud_db_instance.this.*.instance_name, count.index)}_ro"
  vswitch_id            = "${element(alicloud_db_instance.this.*.vswitch_id, count.index)}"
}

resource "alicloud_db_read_write_splitting_connection" "default" {
  count             = "${var.use_rds4mysql_module ?( var.ro_instance_count >0 ? (var.rw_spliting_enable ? 1 : 0) : 0):0}"
  instance_id       = "${element(alicloud_db_instance.this.*.id, count.index)}"
  # connection_prefix = "${var.rw_connection_prefix}"
  distribution_type = "${var.distribution_type}"
  depends_on        = ["alicloud_db_readonly_instance.default"]
  # depends_on        = ["${element(alicloud_db_readonly_instance.default,count.index)}"]
}