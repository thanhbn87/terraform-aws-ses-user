locals {
  temp_file_policy = coalesce(var.temp_file_policy,"${path.module}/Policy.json.tpl")
}

resource "aws_iam_user" "this" {
  count                = var.enabled ? 1 : 0
  name                 = var.ses_user
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  force_destroy        = var.force_destroy
  tags                 = var.tags
}

resource "aws_iam_access_key" "this" {
  count   = var.enabled ? 1 : 0
  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key
}

data "template_file" "ses_policy" {
  count    = var.enabled ? 1 : 0
  template = file(local.temp_file_policy)
  vars {
    resources     = jsonencode(var.resources)
    whitelist_ips = jsonencode(var.whitelist_ips)
  }
}

resource "aws_iam_user_policy" "this" {
  count       = var.enabled ? 1 : 0
  name_prefix = var.user_policy_name_prefix
  user        = aws_iam_user.this.name

  policy = data.template_file.ses_policy.rendered
}
