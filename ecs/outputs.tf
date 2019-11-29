output "instance_ids" {
  value = "${data.alicloud_instances.instance.instances.*.id}"
}
