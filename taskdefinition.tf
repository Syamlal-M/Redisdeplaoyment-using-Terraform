  resource "aws_ecs_task_definition" "redis" {
  family                = "redis"
  container_definitions = file("container.json")

}
