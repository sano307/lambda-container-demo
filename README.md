# lambda-container-demo

How to manage Lambda Container and Amazon ECR on Terraform.

## Requirements

- Terraform 0.14.9
- Python 3.8.8
  - pipenv

## Environment

- macOS (Catalina)

## Usage

First of all, change the Amazon ECR repository name.

```diff
// main.tf
-  ecr_repository_name = "sano307/lambda-container-python"
+  ecr_repository_name = "YOUR_ECR_REPOSITORY_NAME"
```

And then, Check the necessary infra resources and deploy to AWS cloud.

```sh
$ terraform init
$ terraform plan
$ terraform apply
```

Try to invoke an AWS Lambda using AWS CLI.

```sh
$ aws lambda invoke --function-name lambda-container response.json && cat response.json
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}
{"statusCode": 200, "body": "{\"message\": \"This is a container lambda.\"}"}

$ aws lambda invoke \
    --function-name lambda-container out \
    --log-type Tail \
    --query 'LogResult' \
    --output text | base64 -d
START RequestId: 5926d73f-d4c4-46ba-88cf-7cbeed6a4cb7 Version: $LATEST
   id value
0   1   foo
1   2   boo
END RequestId: 5926d73f-d4c4-46ba-88cf-7cbeed6a4cb7
REPORT RequestId: 5926d73f-d4c4-46ba-88cf-7cbeed6a4cb7  Duration: 47.52 ms      Billed Duration: 48 ms  Memory Size: 128 MB     Max Memory Used: 109 MB
```

## Local testing

TBD

## Author

Inseo Kim

## License

MIT
