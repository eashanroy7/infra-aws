# KMS Key for Kubernetes Secrets
resource "aws_kms_key" "eks_secrets_key" {
  description             = "KMS key for encrypting EKS secrets"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "eks_secrets_alias" {
  name          = "alias/eks-secrets-key"
  target_key_id = aws_kms_key.eks_secrets_key.id
}