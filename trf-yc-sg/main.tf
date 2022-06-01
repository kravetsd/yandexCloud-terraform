locals {
  sg-ingress_rules = { for rule in var.sg-ingress_rules :
    "${rule.protocol}-allow-${lookup(rule, "from_port", "")}-${lookup(rule, "to_port", "")}-${lookup(rule, "port", "")}-${md5(jsonencode(rule))}" => rule
  }
  sg-egress_rules = { for rule in var.sg-egress_rules :
    "${rule.protocol}-allow-${lookup(rule, "from_port", "")}-${lookup(rule, "to_port", "")}-${lookup(rule, "port", "")}-${md5(jsonencode(rule))}" => rule
  }

}

resource "yandex_vpc_security_group" "this" {
  count       = var.sg-create ? 1 : 0
  name        = "${var.sg-name}-sg"
  description = var.sg-description
  network_id  = var.sg-vpc_id

  labels = merge({
    resource-type = "sg" },
    var.sg-labels
  )
}

resource "yandex_vpc_security_group_rule" "ingress_rules" {
  for_each = length(yandex_vpc_security_group.this[*]) > 0 ? local.sg-ingress_rules : {}

  security_group_binding = yandex_vpc_security_group.this[0].id
  direction              = "ingress"
  description            = lookup(each.value, "description")
  v4_cidr_blocks         = length(element(split(",", lookup(each.value, "v4_cidr_block", "")), 0)) == 0 ? [] : split(",", lookup(each.value, "v4_cidr_block"))
  from_port              = lookup(each.value, "from_port", "-1")
  to_port                = lookup(each.value, "to_port", "-1")
  protocol               = lookup(each.value, "protocol")
  port                   = lookup(each.value, "port", "-1")
}

resource "yandex_vpc_security_group_rule" "egress_rules" {
  for_each = length(yandex_vpc_security_group.this[*]) > 0 ? local.sg-egress_rules : {}

  security_group_binding = yandex_vpc_security_group.this[0].id
  direction              = "egress"
  description            = lookup(each.value, "description")
  v4_cidr_blocks         = length(element(split(",", lookup(each.value, "v4_cidr_block", "")), 0)) == 0 ? [] : split(",", lookup(each.value, "v4_cidr_block"))
  from_port              = lookup(each.value, "from_port", "-1")
  to_port                = lookup(each.value, "to_port", "-1")
  protocol               = lookup(each.value, "protocol")
  port                   = lookup(each.value, "port", "-1")
}
