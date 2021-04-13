data "aws_ecr_image" "lambda_container" {
  repository_name = local.ecr_repository_name
  image_tag       = local.ecr_image_tag

  depends_on = [
    null_resource.build_and_push_lambda_container_image
  ]
}

resource "aws_ecr_repository" "lambda_container" {
  name                 = local.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "lambda_container" {
  repository = aws_ecr_repository.lambda_container.name

  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Untagged images older than 1 days",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 1
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}
