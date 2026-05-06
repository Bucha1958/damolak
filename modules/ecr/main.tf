resource "aws_ecr_repository" "this" {
  count = length(var.repositories)

  name = var.repositories[count.index]

  image_tag_mutability = "IMMUTABLE"
}