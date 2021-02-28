resource "aws_launch_configuration" "ecs-configuration" {

   name = "ecs-launch-configuration"
   instance_type = "t2.micro"
    image_id  = "${var.ami}"
    iam_instance_profile = "${aws_iam_instance_profile.test_profile.id}"

root_block_device {
      volume_type = "standard"
      volume_size = 100
      delete_on_termination = true

}
lifecycle {
      create_before_destroy = true
    }

	security_groups  = 	["${aws_security_group.allow_ssh.id}"]
	associate_public_ip_address = "false"
	key_name = "${aws_key_pair.keypair.key_name}"
	user_data     = <<EOF
                      #!/bin/bash
                        echo rediscluster >> /etc/ecs/ecs.config
                     EOF
}


