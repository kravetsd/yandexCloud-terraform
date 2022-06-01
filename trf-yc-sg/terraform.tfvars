sg-vpc_id = "example-vpc-id"
sg-name   = "this"
sg-ingress_rules = [
  {
    port          = 22
    protocol      = "TCP"
    v4_cidr_block = "1.1.1.1/32"
    description   = "inbound rule for SSH"
  },
  {
    from_port     = 443
    to_port       = 444
    protocol      = "TCP"
    v4_cidr_block = "1.1.1.1/32"
    description   = "inbound rule for HTTPS"
  },
]