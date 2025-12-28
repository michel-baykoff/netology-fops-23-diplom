resource "local_file" "inventory_kubespray" {
count = var.ghub_actions_output_fix ? 0 : 1

  content  = templatefile("${path.module}/templates/ansible.tftpl", {
    controlplanes = yandex_compute_instance.controlplane
    workers = yandex_compute_instance.worker

  })
  filename = "../../kubespray/inventory/diplomcluster/hosts.yaml"
}
