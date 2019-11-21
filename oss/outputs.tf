output "bucket_id" {
  value = "${alicloud_oss_bucket.oss-bucket.*.id}"
}

output "bucket_acl" {
  value = "${alicloud_oss_bucket.oss-bucket.*.acl}"
}

output "bucket_creation_date" {
  value = "${alicloud_oss_bucket.oss-bucket.*.creation_date}"
}

output "bucket_extranet_endpoint" {
  value = "${alicloud_oss_bucket.oss-bucket.*.extranet_endpoint}"
}

output "bucket_intranet_endpoint" {
  value = "${alicloud_oss_bucket.oss-bucket.*.intranet_endpoint}"
}


output "bucket_owner" {
  value = "${alicloud_oss_bucket.oss-bucket.*.owner}"
}