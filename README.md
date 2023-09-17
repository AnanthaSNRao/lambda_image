# lambda_image
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 111122223333.dkr.ecr.us-east-1.amazonaws.com

aws ecr create-repository --repository-name hello-world --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE

docker tag docker-image:test <ECRrepositoryUri>:latest

docker push 111122223333.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest

aws lambda create-function \
  --function-name hello-world \
  --package-type Image \
  --code ImageUri=111122223333.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest \
  --role arn:aws:iam::111122223333:role/lambda-ex


aws lambda invoke --function-name hello-world response.json