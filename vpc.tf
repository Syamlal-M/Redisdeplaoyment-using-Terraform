#creating the VPC withthe CIDR block"10.0.0.0/16"

  resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc.cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
        Name = "${var.vpc.name}"
  }

}

#Creating Internet gateway and attach to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
        Name = "${var.igw}"
  }
}

#Creating public subnet 1

resource "aws_subnet" "public1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public1.cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.public1.az}"
  tags = {
    Name = "${var.public1.name}"
  }
}

#creating public subnet 2

resource "aws_subnet" "public2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public2.cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.public2.az}"
  tags = {
    Name = "${var.public2.name}"
  }
}

#Creating the private subnet 1

resource "aws_subnet" "private1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private1.cidr}"
  map_public_ip_on_launch = "false"
  availability_zone = "${var.private1.az}"
  tags = {
    Name = "${var.private1.name}"
  }
}


#Creating the private subnet 2

resource "aws_subnet" "private2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private2.cidr}"
  map_public_ip_on_launch = "false"
  availability_zone = "${var.private2.az}"
  tags = {
    Name = "${var.private2.name}"
  }
}

#creating an Elastic IP address for NAT gateway

resource "aws_eip" "nat" {
    vpc      = true
}


#Creating a  NAT gateway in the public subnet ap-northeast-1a

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public1.id}"

 tags = {
    Name = "Redis-NG"
  }
}


#Creating RouteTable for the public subnets

resource "aws_route_table" "rtb-public" {

    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags = {
        Name = "Redis-pub"
    }
}


#Attaching the public subnet 1 for route table



resource "aws_route_table_association" "public1-association" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.rtb-public.id}"
}

#Attaching the public subnet two to the route table

resource "aws_route_table_association" "public2-association" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.rtb-public.id}"
}

#Creating the RouteTable for private subnet


resource "aws_route_table" "rtb-private" {

    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_nat_gateway.nat.id}"
    }

    tags = {
        Name = "Redis-priva"
    }
}


#Attaching private subnet 1 to Route table 


resource "aws_route_table_association" "private1-association" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.rtb-private.id}"
}

#Attaching the private subnet 2 to the Route table

resource "aws_route_table_association" "private2-association" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.rtb-private.id}"
}



#Creating the target group of NLB

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



#Creating NLB 


#esource "aws_lb" "redisnlb" {
 #name               = "Redis-DB"
 #internal           = false
 #load_balancer_type = "network"
  #@subnets            = aws_subnet.public.*.id
#nable_deletion_protection = true
#attaching the public subnets to NLB
#ubnet_mapping {

 #  subnet_id            = "${aws_subnet.public1.id}"
    
 #}

  #ubnet_mapping {
   
#ubnet_id            = "${aws_subnet.public1.id}"
 # }

#}



 
