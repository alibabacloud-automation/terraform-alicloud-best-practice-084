provider "alicloud" {
  version = ">=1.60.0"
  region = "${var.region}"
  profile = "${var.profile}"
  configuration_source = "terraform-alicloud-modules/terraform-alicloud-best-practice-084"
}

module "vpc" {
  source = "./vpc"
  use_vpc_module = "${var.use_vpc_module}"
  vpc_cidr = "${var.vpc_cidr}"
  vpc_name = "${var.vpc_name}"
  cidr_blocks = "${var.cidr_blocks}"
  availability_zones = "${var.availability_zones}"
}

module "kms" {
  source = "./kms"
  use_kms_module = "${var.use_kms_module}"
  is_enabled = "${var.is_enabled}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  description = "${var.description}"
}

module "oss" {
  source = "./oss"
  use_oss_module = "${var.use_oss_module}"
  which_bucket_for_uploading = "${var.which_bucket_for_uploading}"
  bucket_storage_classes = "${var.bucket_storage_classes}"
  bucket_names = "${var.bucket_names}"
  object_key = "${var.object_key}"
  object_source = "${var.object_source}"
  bucket_acls = "${var.bucket_acls}"
  tags = "${var.tags}"
  logging_target_prefix = "${var.logging_target_prefix}"
  sse_algorithm = "${var.sse_algorithm}"
}

module "ram" {
  source = "./ram"
  use_ram_module = "${var.use_ram_module}"
  policy_name = "${var.policy_name}"
  policy_type = "${var.policy_type}"
  mfa_bind_required = "${var.mfa_bind_required}"
  force = "${var.force}"
  ak_status = "${var.ak_status}"
  group_name = "${var.group_name}"
  password = "${var.password}"
  secret_file = "${var.secret_file}"
  display_name = "${var.display_name}"
  group_comments = "${var.group_comments}"
  password_reset_required = "${var.password_reset_required}"
  user_name = "${var.user_name}"
}

module "rds" {
  source = "./rds"
  use_rds_module = "${var.use_rds_module}"
  vswitch_id = "${module.vpc.vswitch_ids[1]}"
  vpc_cidr_block = "${module.vpc.vpc_cidr_block}"
  rds_account_name = "${var.rds_account_name}"
  character_set = "${var.character_set}"
  account_privilege = "${var.account_privilege}"
  rds_count = "${var.rds_count}"
  account_type = "${var.account_type}"
  account_name = "${var.account_name}"
  instance_charge_type = "${var.instance_charge_type}"
  instance_type = "${var.instance_type}"
  tags = "${var.tags}"
  count_format = "${var.count_format}"
  rds_name = "${var.rds_name}"
  engine = "${var.engine}"
  instance_storage = "${var.instance_storage}"
  rds_account_pwd = "${var.rds_account_pwd}"
  db_description = "${var.db_description}"
  rds_zone_id = "${var.rds_zone_id}"
  engine_version = "${var.engine_version}"
}

module "ecs" {
  source = "./ecs"
  ecs_count = "${var.ecs_count}"
  use_ecs_module = "${var.use_ecs_module}"
  vpc_id = "${module.vpc.vpc_id}"
  vswitch_ids = "${module.vpc.vswitch_ids}"
  availability_zones = "${module.vpc.availability_zones}"
  security_group_name = "${var.security_group_name}"
  nic_type = "${var.nic_type}"
  ecs_type = "${var.ecs_type}"
  deletion_protection = "${var.deletion_protection}"
  ecs_instance_charge_type = "${var.ecs_instance_charge_type}"
  disk_size = "${var.disk_size}"
  system_disk_size = "${var.system_disk_size}"
  ecs_internet_charge_type = "${var.ecs_internet_charge_type}"
  ecs_name = "${var.ecs_name}"
  image_name = "${var.image_name}"
  image_owners = "${var.image_owners}"
  key_name = "${var.key_name}"
  disk_category = "${var.disk_category}"
  tags = "${var.tags}"
  ecs_count_format = "${var.ecs_count_format}"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"
}

module "slb" {
  source = "./slb"
  use_slb_module = "${var.use_slb_module}"
  vswitch_id = "${module.vpc.vswitch_ids[1]}"
  instance_ids = "${module.ecs.instance_ids}"
  internet_charge_type = "${var.internet_charge_type}"
  tags = "${var.tags}"
  delete_protection = "${var.delete_protection}"
  specification = "${var.specification}"
  slave_zone_id = "${var.slave_zone_id}"
  address_type = "${var.address_type}"
  master_zone_id = "${var.master_zone_id}"
  slb_name = "${var.slb_name}"
}

module "eip" {
  source = "./eip"
  use_eip_module = "${var.use_eip_module}"
  instance_id = "${module.slb.slb_id}"
  eip_instance_charge_type = "${var.eip_instance_charge_type}"
  isp = "${var.isp}"
  bandwidth = "${var.bandwidth}"
  eip_internet_charge_type = "${var.eip_internet_charge_type}"
}



#### Database
module "rds4mysql" {
  source               = "./db/rds4mysql"
  use_rds4mysql_module = false
  instance_count       = 1
  #################
  #  Instance
  #################
  zone_id      = "cn-shanghai-MAZ5(f,g)"
  tags         = "${var.tags}"
  vswitch_id   = "${module.vpc.vswitch_ids[1]}"
  security_ips = ["${module.vpc.vpc_cidr_block}"]
  instance_name = "terraform_test"
  # instance_type = "rds.mysql.c1.large"
  # instance_storage = 100
  #################
  #  Connection
  #################
  # port                       = 3306
  # connection_prefix          = "terraform-test"

  #################
  #  Database
  #################
  create_database = true
  databases = [
    {
      name          = "db1"
      character_set = "utf8"
      description   = "terraform_test"
    },
    {
      name          = "db2"
      character_set = "utf8"
      description   = "terraform_test"
    },
  ]
  #################
  #  Database Account
  #################
  create_super_account = false
  account_super_name    = "monitor"
  account_super_pwd     = "Test12345678"
  create_app_account = false
  account_app_name      = "appuser"
  account_app_pwd       = "Test12345678"
  # account_app_privilege = "ReadWrite"
  #################
  #  Backup policy
  #################
  # preferred_backup_period     = ["Monday",  "Wednesday",  "Friday"]
  # preferred_backup_time       = "02:00Z-03:00Z"
  # backup_retention_period     = 30
  # enable_backup_log       = true
  # log_backup_retention_period     = 30
  #################
  #  ReadWrite Splitting
  #################
  ro_instance_count = 0
  rw_spliting_enable = true
}
module "rds4sqlsever" {
  source               = "./db/rds4sqlserver"
  use_rds4sqlserver_module = false
  instance_count       = 1
  #################
  #  Instance
  #################
  # instance_charge_type = "Postpaid"
  zone_id      = "cn-shanghai-f"
  tags         = "${var.tags}"
  vswitch_id   = "${module.vpc.vswitch_ids[1]}"
  security_ips = ["${module.vpc.vpc_cidr_block}"]
  instance_name = "terraform_test"
  instance_type = "mssql.x8.medium.s2"
  instance_storage = 100

  #################
  #  Database
  #################
  create_database = false
  databases = [
    {
      name          = "db1"
      character_set = "utf8"
      description   = "terraform_test"
    }
  ]
  #################
  #  Database Account
  #################
  create_super_account = false
  account_super_name    = "monitor"
  account_super_pwd     = "Test12345678"
  create_app_account = false
  account_app_name      = "appuser"
  account_app_pwd       = "Test12345678"
  # account_app_privilege = "ReadWrite"
  #################
  #  Backup policy
  #################
  # preferred_backup_period     = ["Monday",  "Wednesday",  "Friday"]
  # preferred_backup_time       = "02:00Z-03:00Z"
  # backup_retention_period     = 30
  # enable_backup_log       = true
  # log_backup_retention_period     = 30
}

module "rds4postgresql" {
  source               = "./db/rds4postgresql"
  use_rds4postgresql_module = false
  instance_count       = 1
  #################
  #  Instance
  #################
  # instance_charge_type = "Postpaid"
  zone_id      = "cn-shanghai-f"
  tags         = "${var.tags}"
  vswitch_id   = "${module.vpc.vswitch_ids[1]}"
  security_ips = ["${module.vpc.vpc_cidr_block}"]
  instance_type = "pg.x4.large.2c"
  instance_name = "terraform_test"
  instance_storage = 100
  #################
  #  Connection
  #################
  # port                       = 3306
  # connection_prefix          = terraform_test
  # allocate_public_connection = false

  #################
  #  Database
  #################
  create_database = true
  databases = [
    {
      name          = "db1"
      character_set = "UTF8"
      description   = "terraform_test"
    }
  ]
  #################
  #  Database Account
  #################
  create_super_account = false
  account_super_name    = "monitor"
  account_super_pwd     = "Test12345678"
  create_app_account = false
  account_app_name      = "appuser"
  account_app_pwd       = "Test12345678"
  # account_app_privilege = "ReadWrite"
  #################
  #  Backup policy
  #################
  # preferred_backup_period     = ["Monday",  "Wednesday",  "Friday"]
  # preferred_backup_time       = "02:00Z-03:00Z"
  # backup_retention_period     = 30
  # enable_backup_log       = true
  # log_backup_retention_period     = 30

}


module "polardb4mysql" {
  source                   = "./db/polardb4mysql"
  use_polardb4mysql_module = false
  instance_count           = 1
  #################
  #  Instance
  #################
  # instance_charge_type = "Postpaid"
  zone_id             = "cn-shanghai-e"
  tags                = "${var.tags}"
  vswitch_id          = "${module.vpc.vswitch_ids[0]}"
  security_ips        = ["${module.vpc.vpc_cidr_block}"]
  instance_name       = "terraform_test"
  # instance_node_class = "polar.mysql.x4.large"

  #################
  #  Database
  #################
  create_database = false
  databases = [
    {
      name          = "db1"
      character_set = "utf8"
      description   = "terraform_test"
    }
  ]
  #################
  #  Database Account
  #################
  create_super_account = false
  account_super_name    = "monitor"
  account_super_pwd     = "Test12345678"
  create_app_account = false
  account_app_name      = "appuser"
  account_app_pwd       = "Test12345678"
  # account_app_privilege = "ReadWrite"
  #################
  #  Backup policy
  #################
  # preferred_backup_period     = ["Monday",  "Wednesday",  "Friday"]
  # preferred_backup_time       = "02:00Z-03:00Z"
}


module "polardb4postgresql" {
  source                   = "./db/polardb4postgresql"
  use_polardb4postgresql_module = false
  instance_count           = 1
  #################
  #  Instance
  #################
  # instance_charge_type = "Postpaid"
  zone_id             = "cn-shanghai-e"
  tags                = "${var.tags}"
  vswitch_id          = "${module.vpc.vswitch_ids[0]}"
  security_ips        = ["${module.vpc.vpc_cidr_block}"]
  instance_name       = "terraform_test"
  # instance_node_class = "polar.pg.x4.large"

  #################
  #  Database
  #################
  create_database = false
  databases = [
    {
      name          = "db1"
      character_set = "utf8"
      description   = "terraform_test"
    }
  ]
  #################
  #  Database Account
  #################
  create_super_account = false
  account_super_name    = "monitor"
  account_super_pwd     = "Test12345678"
  create_app_account = false
  account_app_name      = "appuser"
  account_app_pwd       = "Test12345678"
  # account_app_privilege = "ReadWrite"
  #################
  #  Backup policy
  #################
  # preferred_backup_period     = ["Monday",  "Wednesday",  "Friday"]
  # preferred_backup_time       = "02:00Z-03:00Z"
}

module "polardb4oracle" {
  source                   = "./db/polardb4oracle"
  use_polardb4oracle_module = false
  instance_count           = 1
  #################
  #  Instance
  #################
  # instance_charge_type = "Postpaid"
  zone_id             = "cn-shanghai-e"
  tags                = "${var.tags}"
  vswitch_id          = "${module.vpc.vswitch_ids[0]}"
  security_ips        = ["${module.vpc.vpc_cidr_block}"]
  instance_name       = "terraform_test"
  # instance_node_class = "polar.o.x4.large"

  #################
  #  Database
  #################
  create_database = false
  databases = [
    {
      name          = "db1"
      character_set = "utf8"
      description   = "terraform_test"
    }
  ]
  #################
  #  Database Account
  #################
  create_super_account = false
  account_super_name    = "monitor"
  account_super_pwd     = "Test12345678"
  create_app_account = false
  account_app_name      = "appuser"
  account_app_pwd       = "Test12345678"
  account_app_privilege = "ReadWrite"
  #################
  #  Backup policy
  #################
  preferred_backup_period     = ["Monday",  "Wednesday",  "Friday"]
  preferred_backup_time       = "02:00Z-03:00Z"
}

module "drds" {
  source          = "./db/drds"
  use_drds_module = false
  instance_count  = 1
  #################
  # Instance
  #################
  zone_id    = "cn-shanghai-g"
  vswitch_id = "${module.vpc.vswitch_ids[1]}"
  # security_ips = ["${module.vpc.vpc_cidr_block}"]
  instance_name   = "terraform-test"
  # instance_series = "drds.sn1.8c16g"
  # specification   = "drds.sn1.8c16g.8C32G"
}
module "redis" {
  source           = "./db/redis"
  use_redis_module = false
  instance_count   = 1
  #################
  # Instance
  #################
  zone_id        = "cn-shanghai-g"
  vswitch_id     = "${module.vpc.vswitch_ids[2]}"
  security_ips   = ["${module.vpc.vpc_cidr_block}"]
  tags           = "${var.tags}"
  instance_class = "redis.master.mid.default"
  instance_name  = "terraform_test"
  engine_version = "4.0"
  #################
  #  Account
  #################
  create_app_account = false
  account_name      = "appuser"
  account_password  = "Hi1234567"
  # account_privilege = "RoleReadWrite"
  #################
  #  Backup Policy
  #################
  # backup_time     = "02:00Z-03:00Z"
  # backup_period       = ["Monday", "Wednesday", "Friday"]
}

module "mongodb" {
  source             = "./db/mongodb"
  use_mongodb_module = false
  instance_count     = 1
  #################
  # Instance
  #################
  zone_id      = "cn-shanghai-g"
  vswitch_id   = "${module.vpc.vswitch_ids[2]}"
  security_ips = ["${module.vpc.vpc_cidr_block}"]

  tags                = "${var.tags}"
  db_instance_class   = "dds.mongo.large"
  db_instance_storage = 100
  instance_name       = "terraform_test"
  engine_version      = "4.0"
  #################
  #  Account
  #################
  root_password = "Hi1234567"

  #################
  #  Backup Policy
  #################
  # backup_time     = ""
  # backup_period       = ""
}

# module "adb4postgresql" {
#   source             = "./db/adb4postgresql"
#   use_adb4postgresql_module = false
#   instance_count     = 1
#   #################
#   # Instance
#   #################
#   zone_id      = "cn-shanghai-g"
#   vswitch_id   = "${module.vpc.vswitch_ids[1]}"
#   security_ips = ["${module.vpc.vpc_cidr_block}"]
#   tags                = "${var.tags}"
#   instance_name          = "terraform-test"
#   engine               = "gpdb"
#   engine_version       = "6.0"
#   instance_class       = "gpdb.group.segsdx2"
#   instance_group_count = "2"
# }
