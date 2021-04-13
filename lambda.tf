resource "aws_lambda_function" "lambda_container" {
  function_name    = "lambda-container"
  package_type     = "Image"
  image_uri        = "${aws_ecr_repository.lambda_container.repository_url}:latest"
  source_code_hash = trimprefix(data.aws_ecr_image.lambda_container.id, "sha256:")
  memory_size      = 128
  timeout          = 5
  role             = aws_iam_role.iam_for_lambda.arn

  depends_on = [
    null_resource.build_and_push_lambda_container_image
  ]
}
