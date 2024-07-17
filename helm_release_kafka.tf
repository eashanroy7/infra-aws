resource "helm_release" "kafka" {
  name       = "kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  version    = "29.3.2"
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  namespace = kubernetes_namespace.kafka.metadata[0].name

  depends_on = [module.eks, kubernetes_namespace.kafka]
}
