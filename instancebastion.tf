#Creating a bastion instance


resource "aws_instance" "bastionserver" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "terra"
    subnet_id  = "${aws_subnet.public2.id}"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.bastion-redis.id}"]
    tags = {
        Name = "bastionredis"
  }
}

