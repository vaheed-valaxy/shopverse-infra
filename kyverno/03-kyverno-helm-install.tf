# HELM Provider
provider "helm" {
  kubernetes = {
    host                   = local.eks_host
    cluster_ca_certificate = base64decode(local.eks_cluster_ca_certificate)
    token                  = local.eks_token  # data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "external_secrets" {
  name       = "kyverno"
  repository = "https://kyverno.github.io/kyverno"
  chart      = "kyverno"
  namespace  = "kyverno"

  version = "YOUR_CHART_VERSION"

  create_namespace = true

  wait            = true
  timeout         = 600
  cleanup_on_fail = true

  values = [
    yamlencode({
      installCRDs = true

      rbac = {
        create = true
      }

      serviceAccount = {
        create = true
        name   = "external-secrets"

        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.kyverno_ecr_role.arn
        }
      }
    })
  ]

  depends_on = [
    aws_iam_role.kyverno_ecr_role,
    aws_iam_role_policy_attachment.kyverno_ecr_secrets_policy_attachment
  ]
}
