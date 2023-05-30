resource "aws_ecr_repository" "repository" {
  name = var.ecr_name
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_lifecycle_policy" "repository-policy" {
  repository = aws_ecr_repository.repository.name
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
