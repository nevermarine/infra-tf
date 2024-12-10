resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.7.6"
  set_list {
    name = "server.extraArgs"
    value = [
      "--insecure"
    ]
  }
  set {
    name  = "configs.credentialTemplates.${var.argo_repo_name}.url"
    value = var.argo_repo_url
  }
  set {
    name  = "configs.credentialTemplates.${var.argo_repo_name}.sshPrivateKey"
    value = var.argo_ssh_private_key
  }
  set {
    name  = "configs.repositories.${var.argo_repo_name}.url"
    value = var.argo_repo_url
  }
}

resource "helm_release" "argocd-start-app" {
  depends_on = [
    helm_release.argocd
  ]
  name       = "argocd-start-app"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "2.0.2"
  set {
    name  = "applications.${var.argo_repo_name}.namespace"
    value = "argocd"
  }
  set {
    name  = "applications.${var.argo_repo_name}.project"
    value = "default"
  }

  set {
    name  = "applications.${var.argo_repo_name}.source.repoURL"
    value = var.argo_repo_url
  }

  set {
    name  = "applications.${var.argo_repo_name}.source.targetRevision"
    value = "HEAD"
  }

  set {
    name  = "applications.${var.argo_repo_name}.source.path"
    value = "./"
  }

  set {
    name  = "applications.${var.argo_repo_name}.source.directory.recurse"
    value = "true"
  }

  set {
    name  = "applications.${var.argo_repo_name}.destination.server"
    value = "https://kubernetes.default.svc"
  }

  set {
    name  = "applications.${var.argo_repo_name}.destination.namespace"
    value = "argocd"
  }

  set {
    name  = "applications.${var.argo_repo_name}.syncPolicy.automated.prune"
    value = "true"
  }

  set {
    name  = "applications.${var.argo_repo_name}.syncPolicy.automated.selfHeal"
    value = "true"
  }

  set_list {
    name  = "applications.${var.argo_repo_name}.syncPolicy.syncOptions"
    value = ["CreateNamespace=true"]
  }
}
