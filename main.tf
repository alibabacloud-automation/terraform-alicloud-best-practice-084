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


