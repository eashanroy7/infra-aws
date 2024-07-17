resource "kubernetes_namespace" "kafka" {
  metadata {
    name = "kafka-namespace"
  }

  depends_on = [module.eks]
}

resource "kubernetes_namespace" "cve-processor" {
  metadata {
    name = "cve-processor-namespace"
  }

  depends_on = [module.eks]
}

resource "kubernetes_namespace" "cve-consumer" {
  metadata {
    name = "cve-consumer-namespace"
  }

  depends_on = [module.eks]
}

# Namespace for Cluster Autoscaler
resource "kubernetes_namespace" "cluster-autoscaler-namespace" {
  metadata {
    name = "cluster-autoscaler-namespace"
  }

  depends_on = [module.eks]
}
