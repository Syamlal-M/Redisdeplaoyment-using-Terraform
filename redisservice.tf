resource "aws_ecs_service" "redis-ecs-service" {
  	name            = "redis-ecs-service"
  	iam_role        = "${aws_iam_role.test_role.name}"
  	cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
  	task_definition = "${aws_ecs_task_definition.redis.family}"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${aws_lb_target_group.redisnw.arn}"
    	container_port    = 80
    	container_name    = "redisdb"
#        vpc_id              = "${aws_vpc.vpc.id}"

	}
}
