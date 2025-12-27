#make diplom network
resource "yandex_vpc_network" "diplom" {
  name = var.vpc_name
}

#make diplom subnets
resource "yandex_vpc_subnet" "diplom-subnet1" {
  name           = var.subnet1
  zone           = var.zone1
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = var.cidr1
}

resource "yandex_vpc_subnet" "diplom-subnet2" {
  name           = var.subnet2
  zone           = var.zone2
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = var.cidr2
}

resource "yandex_vpc_subnet" "diplom-subnet3" {
  name           = var.subnet3
  zone           = var.zone3
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = var.cidr3
}

#locals {
#  subnet_ids = [
#    yandex_vpc_subnet.diplom-subnet1.id,
#    yandex_vpc_subnet.diplom-subnet2.id,
#    yandex_vpc_subnet.diplom-subnet3.id
#  ]
#}
