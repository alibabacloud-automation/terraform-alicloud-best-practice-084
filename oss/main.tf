resource "alicloud_oss_bucket" "oss-bucket" {
  count = "${var.use_oss_module ? length(keys(var.bucket_names)) : 0}"
  bucket = "${lookup(var.bucket_names, element(keys(var.bucket_names),count.index))}"
  acl    = "${lookup(var.bucket_acls,element( keys(var.bucket_acls),count.index))}"
  storage_class = "${lookup(var.bucket_storage_classes,element(keys(var.bucket_storage_classes),count.index))}"
  logging {
    target_bucket = "${lookup(var.bucket_names,element(keys(var.bucket_names),count.index))}"
    target_prefix = "${var.logging_target_prefix}"
  }

  server_side_encryption_rule  {
      sse_algorithm = "${var.sse_algorithm}"
  }

  tags = "${var.tags}"
}

resource "alicloud_oss_bucket_object" "object-source" {
  count = "${var.use_oss_module ? length(keys(var.object_source)) : 0}"
  bucket = "${lookup(var.bucket_names,element(keys(var.bucket_names),var.which_bucket_for_uploading - 1))}"
  key    = "${lookup(var.object_key,element(keys(var.object_key),count.index))}"
  source = "${lookup(var.object_source,element(keys(var.object_source),count.index))}"
}
