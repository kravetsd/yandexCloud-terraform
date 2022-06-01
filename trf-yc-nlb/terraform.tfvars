nlb-name   = "this"
nlb-region = "ru-central1"

nlb-listeners = {
  listener1 = {
    name        = "list1"
    port        = "444"
    target_port = 444
  },
  listener2 = {
    name        = "list2"
    port        = "443"
    target_port = 443
  },
  listener3 = {
    name        = "list3"
    port        = "8081"
    target_port = 8081
  },
  listener4 = {
    name        = "list4"
    port        = "8080"
    target_port = 8080

  }
}
nlb-target_group = {
  healthcheck-name      = "ping8080to80tg0"
  healthcheck_http_port = "8080"
  healthcheck_http_path = "/path/ping"
  name                  = "pinger-tg"
  targets = [
    {
      name      = "test1"
      subnet_id = "example-subnet-id"
      address   = "10.130.0.10"
    },
    {
      name      = "test"
      subnet_id = "example2-subnet-id"
      address   = "10.129.0.10"
    },
  ]
}