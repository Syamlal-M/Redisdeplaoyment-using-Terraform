# Create Redis database using ECS 


Here I am creating the ECS cluster for redis db with the network load balancer
Amazon Elastic Container Service (Amazon ECS) is a highly scalable, fast container management service that makes it easy to run, stop, and manage containers on a cluster. Your containers are defined in a task definition that you use to run individual tasks or tasks within a service. In this context, a service is a configuration that enables you to run and maintain a specified number of tasks simultaneously in a cluster. You can run your tasks and services on a serverless infrastructure that is managed by AWS Fargate. Alternatively, for more control over your infrastructure, you can run your tasks and services on a cluster of Amazon EC2 instances that you manage.


# Requiremnt:

- A private VPC with four subnetting
- bastion ec2 instance in the public subnet 
- ecs ec2 instance in the private subnet
- Two security group


==================================================================================================================
