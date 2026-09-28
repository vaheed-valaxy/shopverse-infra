locals {
  eks_cluster_name       = "${var.project}-${var.env}-eks-cluster"            # ecommerce-dev-eks-cluster
  eks_cluster_subnet_ids = module.vpc.private_subnet_ids
  eks_node_subnet_ids    = module.vpc.private_subnet_ids

  bastion_sg_id = module.bastion_sg.sg_id data.terraform_remote_state.bastion.outputs.bastion_sg_id

  common_tags = {
    Project     = var.project
    Environment = var.env
    Terraform   = "True"
  }

  eks_vpc_public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"          # "shared"
  }

  eks_vpc_private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "owned"           # "shared"
  }

  node_auto_scaler_tags = {
    "k8s.io/cluster-autoscaler/enabled"                   = "true"
    "k8s.io/cluster-autoscaler/${local.eks_cluster_name}" = "owned"
  }

  sg_name = "${var.project}-${var.env}-bastion-sg"
}
