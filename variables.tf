#Main
variable "region" {
  default= ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = "default"
}

#resource management
variable "rds_count" {
  default = 2
}

variable "ecs_count" {
  default = 2
}

variable "use_ecs_module" {
  default = true
}

variable "use_eip_module" {
  default = true
}

variable "use_kms_module" {
  default = true
}

variable "use_oss_module" {
  default = true
}

variable "which_bucket_for_uploading" {
  description = "1 means the first bucket,such as bucket name buc0"
  default = 1
}

variable "use_ram_module" {
  default = true
}

variable "use_rds_module" {
  default = true
}

variable "use_slb_module" {
  default = true
}

variable "use_vpc_module" {
  default = true
}

#VPC
variable "availability_zones" {
  type = "map"
  default = {
    az0 = "cn-shanghai-e"
    az1 = "cn-shanghai-f"
    az2 = "cn-shanghai-g"
  }
}

variable "cidr_blocks" {
  type = "map"
  default = {
    az0 = "10.99.0.0/21"
    az1 = "10.99.8.0/21"
    az2 = "10.99.16.0/21"
  }
}

variable "vpc_name" {
  default = "webserver"
}

variable "vpc_cidr" {
  default = "10.99.0.0/19"
}

#SLB
variable "slb_name" {
  default = "auto_named_slb"
}

variable "master_zone_id" {
  default = "cn-shanghai-f"
}

variable "slave_zone_id" {
  default = "cn-shanghai-g"
}

variable "address_type" {
  default = "intranet"
}

variable "specification" {
  default = "slb.s2.small"
}

variable "delete_protection" {
  default = "off"
}

variable "internet_charge_type" {
  default = "PayByTraffic"
}

variable "tags" {
  type = "map"
  default = {
    app   = "客户端"
    owner = "bestpractice"
    team  = "rds"
    name  = "arthur"
  }
}

#RDS
variable "instance_type" {
  default = "rds.mysql.s3.large"
}

variable "rds_name" {
  default = "rds"
}

variable "count_format" {
  default = "%02d"
}

variable "engine_version" {
  default = "5.7"
}

variable "engine" {
  default = "MySQL"
}

variable "instance_storage" {
  default = "100"
}

variable "instance_charge_type" {
  default = "Postpaid"
}

variable "rds_zone_id" {
  default = "cn-shanghai-MAZ5(f,g)"
}


#db
variable "db_description" {
  default = ""
}


#db ccount
variable "rds_account_name" {
  default = "myuser"
}

variable "rds_account_pwd" {
  default = "Test1234"
}

variable "account_type" {
  default = "Super"
}

variable "account_name" {
  default = "miniapp"
}

variable "character_set" {
  default = "utf8"
}

variable "account_privilege" {
  default = "ReadWrite"
}

#RAM
variable "user_name" {
  default = "test1121"
}

variable "display_name" {
  default = "test01"
}

variable "mfa_bind_required" {
  default = false
}

variable "password_reset_required" {
  default = true
}

variable "password" {
  default = "Test1234!"
}

variable "group_name" {
  default = "app_dev_xy"
}

variable "group_comments" {
  default = "app开发用户组"
}

variable "force" {
  default = true
}

variable "ak_status" {
  default = "Active"
}

variable "secret_file" {
  default = "/Users/baby/accesskey.txt"//自定义文件路径
}

variable "policy_name" {
  type = "map"
  default = {
    policy_name1 = "AliyunOSSFullAccess"
    policy_name2 = "AliyunECSFullAccess"
  }
}

variable "policy_type" {
  type = "map"
  default = {
    policy_type1 = "System"
    policy_type2 = "System"
  }
}

#OSS
variable "sse_algorithm" {
  default = "AES256"//should be in array []string{"AES256", "KMS"}
}

variable "bucket_names" {
  type = "map"
  default = {
    buc0 = "apptest-xy1234"
  }
}

variable "bucket_acls" {
  type = "map"
  default = {
    buc0 = "private"//"private","public-read"
  }
}

variable "bucket_storage_classes" {
  type = "map"
  default = {
    buc0 = "Standard"//"Standard","IA","Archive"
  }
}

variable "logging_target_prefix" {
  default = "log/"
}

variable "object_key" {
  type = "map"
  default = {
    key1 = "IMG_20190815_134210.jpg"//自定义
  }
}

variable "object_source" {
  type = "map"
  default = {
    source1 = "/Users/xianwang/Desktop/IMG_20190815_134210.jpg"//自定义
  }
}

#KMS
variable "description" {
  default = "KMS for OSS"
}

variable "deletion_window_in_days" {
  default = "7"
}

variable "is_enabled" {
  default = true
}

#EIP
variable "eip_internet_charge_type" {
  default = "PayByTraffic"
}

variable "bandwidth" {
  default = "2"
}

variable "isp" {
  default = "BGP"
}


variable "eip_instance_charge_type" {
  default = "PostPaid"
}

#ECS
variable "ecs_count_format" {
  default = "%02d"
}

variable "image_owners" {
  default = "system"
}

variable "image_name" {
  default = "^centos_7_06_64"
}


variable "ecs_name" {
  default = "test"
}

variable "ecs_type" {
  default = "ecs.c5.large"
}


variable "key_name" {
  default = "xianwang_key_pair_1121"
}

variable "ecs_internet_charge_type" {
  default = "PayByTraffic"
}


variable "ecs_instance_charge_type" {
  default = "PostPaid"
}


variable "internet_max_bandwidth_out" {
  default = 0
}

variable "deletion_protection" {
  default = false
}

variable "disk_category" {
  default = "cloud_efficiency"
}

variable "disk_size" {
  default = "0"
}

variable "system_disk_size" {
  default = "40"
}

variable "security_group_name" {
  default = "ali-sg-ec-sz"
}

variable "nic_type" {
  default = "intranet"
}


