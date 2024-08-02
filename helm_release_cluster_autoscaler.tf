resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace = "cluster-autoscaler-namespace"
  version    = "9.37.0"

  set {
    name  = "image.tag"
    value = var.cluster_autoscaler_image_tag # Match the version with the chart version
  }
  set {
    name  = "awsAccessKeyID"
    value = var.aws_access_key
  }
  set {
    name  = "awsSecretAccessKey"
    value = var.aws_secret_access_key
  }
    
  values = [
    file("${path.module}/values/cluster-autoscaler-values.yaml")
  ]
  depends_on = [ kubernetes_namespace.cluster-autoscaler-namespace]
}