resource "local_file" "inventory_kubespray" {

  content  = templatefile("${path.module}/templates/ansible.tftpl", {
    controlplanes = yandex_compute_instance.controlplane
    workers = yandex_compute_instance.worker

  })
  filename = "../../kubespray/inventory/diplomcluster/hosts.yaml"
}
