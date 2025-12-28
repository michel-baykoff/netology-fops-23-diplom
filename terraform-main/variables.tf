
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default     = "b1gl64e88ikeen8dirm0"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = "b1gp9jvqe20q1f94c6c3"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "bucket_name" {
  type        = string
  default     = "terraform_bucket"
  description = ""
}

variable "account_name" {
  type        = string
  default     = "terraform-sa"
  description = " "
}

#diplom network name
variable "vpc_name" {
  type        = string
  default     = "diplom-network"
  description = ""
}


#network zones for iteration

variable "zones" {
  description = "Список зон доступности для распределения ВМ"
  type        = list(string)
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-d"
  ]
}

# subnets for iteration
variable "subnets" {
  description = "Список подсетей для распределения ВМ"
  type        = list(string)
  default = [
    "yandex_vpc_subnet.diplom-subnet1.id",
    "yandex_vpc_subnet.diplom-subnet2.id",
    "yandex_vpc_subnet.diplom-subnet3.id"
  ]
}


# Network zones
variable "zone1" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone2" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone3" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# network cidrs
variable "cidr1" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "cidr2" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "cidr3" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
# subnets name
variable "subnet1" {
  type        = string
  default     = "diplom-subnet1"
  description = "diplom subnet 1"
}

variable "subnet2" {
  type        = string
  default     = "diplom-subnet2"
  description = "diplom subnet 2"
}
variable "subnet3" {
  type        = string
  default     = "diplom-subnet3"
  description = "siplom subnet 3"
}

variable "os_image" {
  type    = string
  default = "debian-12"
}


#controlPlane vars
#variable "yandex_compute_instance_controlplane" {
#  type        = list(object({
#    vm_name = string
#    cores = number
#    memory = number
#    core_fraction = number
#    count_vms = number
#    platform_id = string
#  }))
#
#  default = [{
#      vm_name = "control"
#      cores         = 2
#      memory        = 4
#      core_fraction = 5
#      count_vms = 1
#      platform_id = "standard-v1"
#    }]
#}

#variable "boot_disk_control" {
#  type        = list(object({
#    size = number
#    type = string
#    }))
#    default = [ {
#    size = 10
#    type = "network-hdd"
#  }]
#}


#controlplane nodes
variable "controlplane_count" {
  type    = number
  default = 3
}

variable "controlplane_resources" {
  type = object({
    cores         = number
    memory        = number
    size          = number
    core_fraction = number
    platform_id   = string
  })
  default = {
    cores         = 2
    memory        = 4
    size          = 10
    core_fraction = 100
    platform_id   = "standard-v3"
  }
}

#worker vars
variable "worker_count" {
  type    = number
  default = 3
}

variable "worker_resources" {
  type = object({
    cpu           = number
    ram           = number
    disk          = number
    core_fraction = number
    platform_id   = string
  })
  default = {
    cpu           = 2
    ram           = 2
    disk          = 10
    core_fraction = 100
    platform_id   = "standard-v3"
  }
}


#Cloudconfig vars

variable "cloudconfig_username" {
  type    = string
  default = "op"
}

#variable "user_groups" {
#  type    = string
#  default = "sudo"
#}
#
#variable "sudo_rule" {
#  type    = string
#  default = "ALL=(ALL) NOPASSWD:ALL"
#}

#github actions fix
variable "ssh_public_key" {
  type = string
  default = ""
  description="please set it via OS ENV TF_VAR_SSH_PUBLIC_KEY="
}
