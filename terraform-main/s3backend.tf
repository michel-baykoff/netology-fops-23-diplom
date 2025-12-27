#resource "yandex_iam_service_account_static_access_key" "terraform_service_account_key" {
#  service_account_id = yandex_iam_service_account.service.id
#}
#
#resource "yandex_storage_bucket" "tf-bucket" {
#  bucket     = "tf-state-eiw1ooy4ierah1ahregh"
#  access_key = yandex_iam_service_account_static_access_key.terraform_service_account_key.access_key
#  secret_key = yandex_iam_service_account_static_access_key.terraform_service_account_key.secret_key
#
#  anonymous_access_flags {
#    read = false
#    list = false
#  }
#
##  force_destroy = true
#
#  provisioner "local-exec" {
#    command = "echo export AWS_ACCESS_KEY=${yandex_iam_service_account_static_access_key.terraform_service_account_key.access_key} > ./tfbackend.tfvars"
#  }
#
#  provisioner "local-exec" {
#    command = "echo export AWS_SECRET_KEY=${yandex_iam_service_account_static_access_key.terraform_service_account_key.secret_key} >> ./tfbackend.tfvars"
#  }
#}

terraform {
  backend "s3" {
    bucket = "tf-state-eiw1ooy4ierah1ahregh"
    key    = "tf-state/terraform-main.tfstate"
    region = "ru-central1"

    endpoint = "https://storage.yandexcloud.net"
    #    sts_endpoint = "iam.api.cloud.yandex.net"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}
