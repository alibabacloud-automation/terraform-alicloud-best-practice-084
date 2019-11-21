resource "alicloud_ram_user" "user" {
  count = "${var.use_ram_module ? 1 : 0}"
  name         = "${var.user_name}"
  display_name = "${var.display_name}"
  force        = "${var.force}"
}

resource "alicloud_ram_login_profile" "profile" {
  count = "${var.use_ram_module ? 1 : 0}"
  user_name = "${alicloud_ram_user.user.0.name}"
  password  = "${var.password}"
  mfa_bind_required = "${var.mfa_bind_required}"
  password_reset_required = "${var.password_reset_required}"
}

resource "alicloud_ram_access_key" "ak" {
  count = "${var.use_ram_module ? 1 : 0}"
  user_name   = "${alicloud_ram_user.user.0.name}"
  status      = "${var.ak_status}"
  secret_file = "${var.secret_file}"
}

resource "alicloud_ram_group" "group" {
  count = "${var.use_ram_module ? 1 : 0}"
  name     = "${var.group_name}"
  comments = "${var.group_comments}"
  force    = "${var.force}"
}

resource "alicloud_ram_group_membership" "membership" {
  count = "${var.use_ram_module ? 1 : 0}"
  group_name = "${alicloud_ram_group.group.0.name}"
  user_names = "${alicloud_ram_user.user.*.name}"
}

resource "alicloud_ram_user_policy_attachment" "attach" {
  count = "${var.use_ram_module ? length(var.policy_name): 0}"
  policy_name = "${lookup(var.policy_name,element(keys(var.policy_name),count.index))}"
  user_name = "${alicloud_ram_user.user.0.name}"
  policy_type = "${lookup(var.policy_type,element(keys(var.policy_type),count.index))}"
}


