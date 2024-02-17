resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"
  tags = {
    Name = "ecs-cluster"
  }
}
