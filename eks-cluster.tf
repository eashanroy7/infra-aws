module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  ##########################################################################
  ########################### EKS CLUSTER

  # EKS Cluster Configuration
  cluster_name    = "eks-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # Observability
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Encryption
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = aws_kms_key.eks_secrets_key.arn
  }

  # Identity and Access
  iam_role_arn = aws_iam_role.eks_cluster_role.arn

  # Addons
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  # Networking
  vpc_id                    = aws_vpc.main.id
  subnet_ids                = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id, aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
  control_plane_subnet_ids  = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
  cluster_security_group_id = aws_security_group.security_group.id

  # Tags
  tags = {
    Name = "eks-cluster"
  }

  # Explicit Dependencies for EKS Cluster
  depends_on = [
    aws_subnet.public_subnet_1,
    aws_subnet.public_subnet_2,
    aws_subnet.public_subnet_3,
    aws_subnet.private_subnet_1,
    aws_subnet.private_subnet_2,
    aws_subnet.private_subnet_3,
    aws_security_group.security_group,
    aws_iam_role.eks_cluster_role,
    aws_kms_key.eks_secrets_key
  ]

  ##########################################################################
  ########################### EKS MANAGED NODE GROUP(s)

  eks_managed_node_groups = {
    eks_node_group = {
      # Node Group Name
      name = "eks-node-group"

      # Scaling Configuration  
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      # Node Configuration
      instance_types = var.instance_types
      ami_type       = var.ami_type
      capacity_type  = "ON_DEMAND"
      disk_size      = var.disk_size

      # Node IAM Role
      iam_role_arn = aws_iam_role.eks_worker_node_role.arn

      # Node Group Networking
      subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]

      # Optional: Set maximum unavailable nodes during updates
      update_config = {
        max_unavailable = var.max_unavailable
      }

      # Node Group Tags
      tags = {
        Name = "eks-node-group"
      }

      # Explicit Dependencies for Node Group(s)
      depends_on = [
        aws_iam_role.eks_worker_node_role
      ]
    }
  }
  # Cluster access entry to add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true
}