#Web-app balancer
resource "yandex_lb_network_load_balancer" "netology-lb-web-app" {
  name = "web-app"
  listener {
    name        = "web-app-listener"
    port        = 80
    target_port = 30080
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.netology-lb-target-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 30080
      }
    }
  }
  depends_on = [yandex_lb_network_load_balancer.netology-lb-grafana]
}

#Grafana balancer
resource "yandex_lb_network_load_balancer" "netology-lb-grafana" {
  name = "grafana"
  listener {
    name        = "grafana-listener"
    port        = 80
    target_port = 30003
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.netology-lb-target-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 30003
      }
    }
  }
  depends_on = [yandex_lb_target_group.netology-lb-target-group]
}

#Target group
resource "yandex_lb_target_group" "netology-lb-target-group" {
  name       = "netology-lb-target-group"
  depends_on = [yandex_compute_instance.worker]
  dynamic "target" {
    for_each = yandex_compute_instance.worker
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}
