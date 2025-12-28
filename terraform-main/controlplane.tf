data "yandex_compute_image" "debian12" {
  family = var.os_image
}

##controlplane nodes
#variable "controlplane_count" {
#  type    = number
#  default = 3
#}
#
#variable "controlplane_resources" {
#  type = object({
#    cores         = number
#    memory        = number
#    size          = number
#    core_fraction = number
#    platform_id   = string
#  })
#  default = {
#    cores         = 4
#    memory        = 8
#    size          = 10
#    core_fraction = 5
#    platform_id   = "standard-v1"
#  }
#}

resource "yandex_compute_instance" "controlplane" {
  name                      = "controlplane-${count.index + 1}"
  platform_id               = var.controlplane_resources.platform_id
  allow_stopping_for_update = true
  count                     = var.controlplane_count
  zone                      = element(var.zones, count.index % length(var.zones))
  #  zone = var.zones
  resources {
    cores         = var.controlplane_resources.cores
    memory        = var.controlplane_resources.memory
    core_fraction = var.controlplane_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian12.image_id
      #      type     = var.boot_disk_control[0].type
      size = var.controlplane_resources.size
    }
  }

    metadata = {
      ssh-keys = "debian:${local.ssh_public_key}"
      serial-port-enable = "1"
#      user-data = templatefile(
#      "${path.module}/templates/cloud-config.tftpl",
#        {
#        username        = var.cloudconfig_username
#        user_groups    = var.cloudconfig_groups
#        sudo_rule      = var.cloudconfig_sudo_rule
#        ssh_public_key  = local.ssh-public-key
#        hostname        = var.cloudconfig_hostname
#        environment     = var.cloudconfig_environment
#        }
#      )
    }

  network_interface {
   
    #    subnet_id = yandex_vpc_subnet.diplom-subnet1.id
    #    subnet_id = yandex_vpc_subnet.element(var.zones, count.index % length(var.zones)).id
    #    subnet_id = yandex_vpc_subnet.diplom-network[count.index % length(var.zones)].id
    #    subnet_id = yandex_vpc_subnet.diplom[var.zones[each.key % length(var.zones)]].id
         subnet_id = local.subnet_ids[count.index]
    nat       = true

  }

  scheduling_policy {
    preemptible = true
  }
}

#worker nodes code

#variable "worker_count" {
#  type    = number
#  default = 3
#}

#variable "worker_resources" {
#  type = object({
#    cpu         = number
#    ram         = number
#    disk        = number
#    core_fraction = number
#    platform_id = string
#  })
#  default = {
#    cpu         = 4
#    ram         = 8
#    disk        = 10
#    core_fraction = 10
#    platform_id = "standard-v1"
#  }
#}

#resource "yandex_compute_instance" "worker" {
#  depends_on                = [yandex_compute_instance.controlplane]
#  count                     = var.worker_count
#  allow_stopping_for_update = true
#  name                      = "worker-${count.index + 1}"
#  platform_id               = var.worker_resources.platform_id
#  zone                      = element(var.zones, count.index % length(var.zones))
#  #  zone = var.zone${count.index + 1}
#  resources {
#    cores         = var.worker_resources.cpu
#    memory        = var.worker_resources.ram
#    core_fraction = var.worker_resources.core_fraction
#  }
#
#  boot_disk {
#    initialize_params {
#      image_id = data.yandex_compute_image.debian12.image_id
#      size     = var.worker_resources.disk
#    }
#  }
#
#  #  metadata = {
#  #    ssh-keys           = "ubuntu:${local.ssh-keys}"
#  #    serial-port-enable = "1"
#  #    user-data          = data.template_file.cloudinit.rendered
#  #  }
#
#  network_interface {
#  #  subnet_id = "yandex_vpc_subnet.element(var.zones, count.index % length(var.zones)).id"
#  #  subnet_id = element(var.subnets, count.index % length(var.subnets))
#    subnet_id = local.subnet_ids[count.index]
#    nat       = true
#
#  }
#
#  scheduling_policy {
#    preemptible = true
#  }
#}
