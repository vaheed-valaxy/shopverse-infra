resource "aws_iam_policy" "kyverno_ecr_policy" {
  name        = "${local.resource_name}-kyverno-ecr-policy"
  description = "Allow Kyverno to read /${var.project}/${var.env} ecr repos"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # ECR Authentication
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
        # Resource = "arn:aws:ssm:${var.region}:${local.aws_account_id}:parameter/${var.project}/${var.env}/*"
      },

      # ECR Image Read Access
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = "arn:aws:ecr:us-east-1:${local.aws_account_id}:repository:/shopverse/*"
        # Resource = "arn:aws:ssm:${var.region}:${local.aws_account_id}:parameter/${var.project}/${var.env}/*"
      }

    ]
  })
}

resource "aws_iam_role_policy_attachment" "kyverno_ecr_policy_attachment" {
  role       = aws_iam_role.kyverno_ecr_role.name
  policy_arn = aws_iam_policy.kyverno_ecr_policy.arn
}
