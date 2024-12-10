variable "argo_repo_name" {
  type        = string
  description = "Name for ArgoCD repo"
}

variable "argo_repo_url" {
  type        = string
  description = "Repository URL for ArgoCD secret"
}

variable "argo_ssh_private_key" {
  type        = string
  description = "SSH key for ArgoCD access to repo"
}
