<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.54.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_file.cloud_config](https://registry.terraform.io/providers/bpg/proxmox/0.54.0/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.vm](https://registry.terraform.io/providers/bpg/proxmox/0.54.0/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent"></a> [agent](#input\_agent) | n/a | `bool` | `false` | no |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | n/a | `string` | `"x86-64-v2-AES"` | no |
| <a name="input_default_user"></a> [default\_user](#input\_default\_user) | n/a | <pre>object(<br>    {<br>      name = string<br>      # pass    = string<br>      ssh_key = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_disk"></a> [disk](#input\_disk) | n/a | <pre>object(<br>    {<br>      datastore_id    = optional(string, "local-lvm")<br>      ci_datastore_id = optional(string, "local")<br>      interface       = optional(string, "scsi0")<br>      file_id         = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_net"></a> [net](#input\_net) | n/a | <pre>object(<br>    {<br>      addr = optional(string, "dhcp")<br>      gw   = optional(string)<br><br>      bridge  = optional(string, "vmbr1")<br>      vlan_id = optional(number)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | n/a | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | n/a | `string` | `"l26"` | no |
| <a name="input_packages"></a> [packages](#input\_packages) | n/a | `list(string)` | <pre>[<br>  "tmux",<br>  "vim",<br>  "htop",<br>  "iftop",<br>  "iotop",<br>  "fastfetch"<br>]</pre> | no |
| <a name="input_size"></a> [size](#input\_size) | n/a | <pre>object(<br>    {<br>      memory  = optional(number, 2048)<br>      cores   = optional(number, 2)<br>      sockets = optional(number, 1)<br>      disk    = optional(number, 30)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | n/a | `string` | `"Europe/Moscow"` | no |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | n/a | `number` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
