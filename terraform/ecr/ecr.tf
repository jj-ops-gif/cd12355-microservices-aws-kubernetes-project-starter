module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "coworking"

  repository_read_write_access_arns = ["arn:aws:iam::111928192316:role/service-role/codebuild-coworking-service-role"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}