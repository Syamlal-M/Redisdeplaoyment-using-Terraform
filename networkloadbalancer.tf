    resource "aws_lb" "network-load-balancer" {
    name                = "network-load-balancer"
	internal           = false
	 load_balancer_type = "network"
    
    subnets             = ["${aws_subnet.public2.id}", "${aws_subnet.public2.id}"]

    }



resource "aws_lb_target_group" "redisnw" {
  name     = "Redis-target"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${aws_vpc.vpc.id}"
  #target_type = "Instance"
  tags = {
    Name = "redis"
  }
}



resource "aws_lb_listener" "network-lb" {
    load_balancer_arn = "${aws_lb.network-load-balancer.arn}"
    port              = "80"
    protocol          = "TCP"

    default_action {
        target_group_arn = "${aws_lb_target_group.redisnw.arn}"
        type             = "forward"
    }
}
