# Data source to get the LoadBalancer DNS name
data "kubernetes_service" "istio_gateway" {
  metadata {
    name      = "gateway"
    namespace = "istio-system"
  }
  # Depends on the Istio Gateway Helm chart that creates the Gateway service of type Load Balancer
  depends_on = [
    helm_release.gateway 
  ]
}

# Local value to store the LoadBalancer DNS
locals {
  lb_hostname = data.kubernetes_service.istio_gateway.status[0].load_balancer[0].ingress[0].hostname
}

# Fetch the Route 53 Hosted Zone ID
data "aws_route53_zone" "selected" {
  name         = "eashanroy.me."
  private_zone = false
}

# Create Route 53 A Record
resource "aws_route53_record" "grafana" {
  zone_id = data.aws_route53_zone.selected.zone_id 
  name    = "grafana.eashanroy.me"
  type    = "A"

  alias {
    name                   = local.lb_hostname
    zone_id                = "Z35SXDOTRQ7X7K"  # Route 53 Hosted Zone ID for LB in US East Region
    evaluate_target_health = false
  }

  depends_on = [
    helm_release.gateway
  ]
}

output "lb_dns" {
  value = local.lb_hostname
}