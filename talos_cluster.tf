locals {
  talos_cluster_vip    = "10.0.0.37"
  talos_bootstrap_node = "10.0.0.31"
  talos_cluster_name   = "pxmx-talos"
}
resource "talos_machine_secrets" "machine_secrets" {}

data "talos_client_configuration" "talosconfig" {
  cluster_name         = local.talos_cluster_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  #   # Read https://www.talos.dev/v1.8/talos-guides/network/vip/#caveats
  #   endpoints            = [local.talos_cluster_vip]
  endpoints = [for i in mikrotik_dns_record.talos_master : i.address]
}

data "talos_machine_configuration" "machineconfig_master" {
  cluster_name     = local.talos_cluster_name
  cluster_endpoint = "https://${local.talos_bootstrap_node}:6443"
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "machineconfig_master_apply" {
  count = local.talos_master_count
  #   depends_on                  = [ proxmox_virtual_environment_vm.talos_master[count.index] ]
  depends_on                  = [proxmox_virtual_environment_vm.talos_master]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_master.machine_configuration
  node                        = mikrotik_dns_record.talos_master[count.index].address
  config_patches = [
    yamlencode({
      machine = {
        network = {
          interfaces = [
            {
              interface = "eth0"
              vip = {
                ip = local.talos_cluster_vip
              }
            }
          ]
        }
      }
    })
  ]
}

data "talos_machine_configuration" "machineconfig_worker" {
  cluster_name     = local.talos_cluster_name
  cluster_endpoint = "https://${local.talos_cluster_vip}:6443"
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "machineconfig_worker_apply" {
  count = local.talos_worker_count
  #   depends_on                  = [ proxmox_virtual_environment_vm.talos_worker[count.index] ]
  depends_on                  = [proxmox_virtual_environment_vm.talos_worker]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_worker.machine_configuration
  node                        = mikrotik_dns_record.talos_worker[count.index].address
}

resource "talos_machine_bootstrap" "bootstrap" {
  depends_on           = [talos_machine_configuration_apply.machineconfig_master_apply]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = mikrotik_dns_record.talos_master[0].address
}

data "talos_cluster_health" "health" {
  depends_on           = [talos_machine_configuration_apply.machineconfig_master_apply, talos_machine_configuration_apply.machineconfig_worker_apply]
  client_configuration = data.talos_client_configuration.talosconfig.client_configuration
  control_plane_nodes  = [for i in mikrotik_dns_record.talos_master : i.address]
  worker_nodes         = [for i in mikrotik_dns_record.talos_worker : i.address]
  endpoints            = data.talos_client_configuration.talosconfig.endpoints
}

# data "talos_cluster_kubeconfig" "kubeconfig" {
#   depends_on           = [ talos_machine_bootstrap.bootstrap, data.talos_cluster_health.health ]
#   client_configuration = talos_machine_secrets.machine_secrets.client_configuration
#   node                 = local.talos_cluster_vip
# }

resource "talos_cluster_kubeconfig" "kubeconfig" {
  depends_on           = [talos_machine_bootstrap.bootstrap, data.talos_cluster_health.health]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = local.talos_cluster_vip
}

output "talosconfig" {
  value     = data.talos_client_configuration.talosconfig.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}
