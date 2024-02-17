resource "aws_ecr_repository" "service-1" {
  name = "uday-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
