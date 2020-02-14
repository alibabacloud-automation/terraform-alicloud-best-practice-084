output "ids" {
  value = "${alicloud_polardb_cluster.default.*.id}"
}