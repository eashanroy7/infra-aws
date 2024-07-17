resource "helm_release" "cluster_autoscaler" {
  name = "cluster-autoscaler"
  repository = "https://github.com/csye7125-su24-team17/helm-eks-autoscaler.git"
  chart     = "${var.chart_path}/${var.helm_autoscaler_chart}"
  version   = "0.1.0"
  #   namespace = kubernetes_namespace.cluster-autoscaler-namespace.metadata[0].name
  namespace  = "kube-system"

  depends_on = [module.eks, kubernetes_namespace.cluster-autoscaler-namespace]
}
