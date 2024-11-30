<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_mikrotik"></a> [mikrotik](#requirement\_mikrotik) | 0.16.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.66.1 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.7.0-alpha.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mikrotik"></a> [mikrotik](#provider\_mikrotik) | 0.16.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.3 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.66.1 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.7.0-alpha.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mikrotik_dns_record.lb](https://registry.terraform.io/providers/ddelnano/mikrotik/0.16.1/docs/resources/dns_record) | resource |
| [mikrotik_dns_record.nas](https://registry.terraform.io/providers/ddelnano/mikrotik/0.16.1/docs/resources/dns_record) | resource |
| [mikrotik_dns_record.patchy](https://registry.terraform.io/providers/ddelnano/mikrotik/0.16.1/docs/resources/dns_record) | resource |
| [mikrotik_dns_record.sanae](https://registry.terraform.io/providers/ddelnano/mikrotik/0.16.1/docs/resources/dns_record) | resource |
| [mikrotik_dns_record.talos_master](https://registry.terraform.io/providers/ddelnano/mikrotik/0.16.1/docs/resources/dns_record) | resource |
| [mikrotik_dns_record.talos_worker](https://registry.terraform.io/providers/ddelnano/mikrotik/0.16.1/docs/resources/dns_record) | resource |
| [null_resource.talos_master_trigger](https://registry.terraform.io/providers/hashicorp/null/3.2.3/docs/resources/resource) | resource |
| [null_resource.talos_worker_trigger](https://registry.terraform.io/providers/hashicorp/null/3.2.3/docs/resources/resource) | resource |
| [proxmox_virtual_environment_download_file.rocky_lvm](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_download_file.talos_image](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_file.lb](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.master](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.ran](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.sanae](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.worker](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.lb](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.master](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.ran](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.sanae](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.talos_master](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.talos_worker](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.worker](https://registry.terraform.io/providers/bpg/proxmox/0.66.1/docs/resources/virtual_environment_vm) | resource |
| [talos_cluster_kubeconfig.kubeconfig](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/resources/cluster_kubeconfig) | resource |
| [talos_machine_bootstrap.bootstrap](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.machineconfig_master_apply](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.machineconfig_worker_apply](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.machine_secrets](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/resources/machine_secrets) | resource |
| [talos_client_configuration.talosconfig](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/data-sources/client_configuration) | data source |
| [talos_cluster_health.health](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/data-sources/cluster_health) | data source |
| [talos_image_factory_urls.image](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/data-sources/image_factory_urls) | data source |
| [talos_machine_configuration.machineconfig_master](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/data-sources/machine_configuration) | data source |
| [talos_machine_configuration.machineconfig_worker](https://registry.terraform.io/providers/siderolabs/talos/0.7.0-alpha.0/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_search_domain"></a> [dns\_search\_domain](#input\_dns\_search\_domain) | n/a | `string` | n/a | yes |
| <a name="input_k8s_gw"></a> [k8s\_gw](#input\_k8s\_gw) | n/a | `string` | n/a | yes |
| <a name="input_mikrotik_cert"></a> [mikrotik\_cert](#input\_mikrotik\_cert) | Path to Mikrotik certificate | `string` | n/a | yes |
| <a name="input_mikrotik_host"></a> [mikrotik\_host](#input\_mikrotik\_host) | mikrotik | `string` | n/a | yes |
| <a name="input_mikrotik_password"></a> [mikrotik\_password](#input\_mikrotik\_password) | n/a | `string` | n/a | yes |
| <a name="input_mikrotik_username"></a> [mikrotik\_username](#input\_mikrotik\_username) | n/a | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Proxmox Web UI password | `string` | n/a | yes |
| <a name="input_proxmox_endpoint"></a> [proxmox\_endpoint](#input\_proxmox\_endpoint) | Endpoint to Proxmox Web UI | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | Path to SSH private key for Proxmox node | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Path to SSH public key for use in VM modules | `string` | n/a | yes |
| <a name="input_ssh_username"></a> [ssh\_username](#input\_ssh\_username) | SSH username for Proxmox node | `string` | n/a | yes |
| <a name="input_target_node"></a> [target\_node](#input\_target\_node) | n/a | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Proxmox Web UI username | `string` | n/a | yes |
| <a name="input_vm_gw"></a> [vm\_gw](#input\_vm\_gw) | n/a | `string` | n/a | yes |
| <a name="input_vm_subnet"></a> [vm\_subnet](#input\_vm\_subnet) | VM CIDR subnet. Needed only for DNS records | `string` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | Username for user in VM modules | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_talosconfig"></a> [talosconfig](#output\_talosconfig) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
