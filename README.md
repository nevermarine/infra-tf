<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_mikrotik"></a> [mikrotik](#requirement\_mikrotik) | 0.16.1 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.66.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mikrotik"></a> [mikrotik](#provider\_mikrotik) | 0.16.1 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.66.1 |

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

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
