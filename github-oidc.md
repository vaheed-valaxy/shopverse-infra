## Image Repos  
- frontend - `shopverse/frontend`
- backend - `shopverse/backend`

## OIDC
- frontend
  - Permissions: `AmazonEC2ContainerRegistryPowerUser`
  - Trust Policy
  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::254405569649:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:vaheed-valaxy@271317682/shopverse-frontend@1345632268:*"
                }
            }
        }
    ]
}

```
