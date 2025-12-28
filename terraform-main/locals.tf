locals {
  subnet_ids = [
    yandex_vpc_subnet.diplom-subnet1.id,
    yandex_vpc_subnet.diplom-subnet2.id,
    yandex_vpc_subnet.diplom-subnet3.id
  ]
}

locals {
  ssh_public_key = file("../../.ssh/id_ed25519.pub")
}
