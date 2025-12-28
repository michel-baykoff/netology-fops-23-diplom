resource "yandex_compute_instance" "worker" {
  depends_on                = [yandex_compute_instance.controlplane]
  count                     = var.worker_count
  allow_stopping_for_update = true
  name                      = "worker-${count.index + 1}"
  platform_id               = var.worker_resources.platform_id
  zone                      = element(var.zones, count.index % length(var.zones))
  #  zone = var.zone${count.index + 1}
  resources {
    cores         = var.worker_resources.cpu
    memory        = var.worker_resources.ram
    core_fraction = var.worker_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian12.image_id
      size     = var.worker_resources.disk
    }
  }

    metadata = {
      ssh-keys           = "debian:${local.ssh_public_key}"
      serial-port-enable = "1"
#      user-data = templatefile(
#      "${path.module}/templates/cloud-config.tftpl",
#        {
#        username        = var.cloudconfig_username
#        user_groups    = var.cloudconfig_user_groups
#        sudo_rule      = var.cloud_config_sudo_rule
#        ssh_public_key  = local.ssh-public-key
#        hostname        = var.cloudconfig_hostname
#        environment     = var.cloudconfig_environment
#        }
#      )
    }

  network_interface {
  #  subnet_id = "yandex_vpc_subnet.element(var.zones, count.index % length(var.zones)).id"
  #  subnet_id = element(var.subnets, count.index % length(var.subnets))
    subnet_id = local.subnet_ids[count.index]
    nat       = true

  }

  scheduling_policy {
    preemptible = true
  }
}
