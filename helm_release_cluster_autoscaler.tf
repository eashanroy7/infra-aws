resource "null_resource" "clone_repo_autoscaler" {
  provisioner "local-exec" {
    command = "git clone https://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@github.com/csye7125-su24-team17/helm-eks-autoscaler.git ./modules/charts/helm-eks-autoscaler"
  }
}
resource "kubernetes_secret" "image_pull_secret" {
  metadata {
    name      = "k8spullsecret"
    namespace = "kube-system"
  }

  data = {
    ".dockerconfigjson" = var.dockerconfigjson
  }

  type = "kubernetes.io/dockerconfigjson"
  depends_on = [ module.eks,kubernetes_namespace.cluster-autoscaler-namespace ]
}


resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://github.com/csye7125-su24-team17/helm-eks-autoscaler.git"
  chart      = var.chart_path_autoscaler
  version    = "0.1.0"
  # namespace = kubernetes_namespace.cluster-autoscaler-namespace.metadata[0].name
  namespace = "kube-system"

  depends_on = [module.eks, kubernetes_namespace.cluster-autoscaler-namespace,kubernetes_secret.image_pull_secret]
}
