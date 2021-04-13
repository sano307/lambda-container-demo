resource "null_resource" "build_and_push_lambda_container_image" {
  triggers = {
    docker_file = md5(file("${path.module}/lambda/Dockerfile"))
    python_file = md5(file("${path.module}/lambda/index.py"))
    pipfile_file = md5(file("${path.module}/lambda/Pipfile"))
    pipfile_lock_file = md5(file("${path.module}/lambda/Pipfile.lock"))
  }

  provisioner "local-exec" {
    command = <<EOF
      aws ecr get-login-password --region ${local.region} | docker login --username AWS --password-stdin ${local.account_id}.dkr.ecr.${local.region}.amazonaws.com
      docker build -f lambda/Dockerfile -t ${aws_ecr_repository.lambda_container.repository_url}:${local.ecr_image_tag} lambda
      docker tag ${aws_ecr_repository.lambda_container.repository_url}:${local.ecr_image_tag} ${aws_ecr_repository.lambda_container.repository_url}:${local.ecr_image_tag}
      docker push ${aws_ecr_repository.lambda_container.repository_url}:${local.ecr_image_tag}
    EOF
  }
}
