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
| [proxmox_virtual_environment_download_file.image](https://registry.terraform.io/providers/bpg/proxmox/0.54.0/docs/resources/virtual_environment_download_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | n/a | `string` | `"iso"` | no |
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | n/a | `string` | `"local"` | no |
| <a name="input_image_file_name"></a> [image\_file\_name](#input\_image\_file\_name) | n/a | `string` | n/a | yes |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | n/a | `string` | n/a | yes |
| <a name="input_target_node"></a> [target\_node](#input\_target\_node) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_id"></a> [image\_id](#output\_image\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
