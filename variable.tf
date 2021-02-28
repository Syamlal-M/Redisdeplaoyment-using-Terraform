variable "ami" { 
    default = "ami-09d28faae2e9e7138"
}


variable "vpc" {
    type = map(string)
    default = {
        "name" = "Redis-vpc"
        "cidr" = "10.0.0.0/16"

}
}
variable "igw" {
    default = "redis-igw"
}


variable "public1" { 
type = "map"
    default = {
        "name" = "redis-pub1a"
        "cidr" = "10.0.0.0/24"
        "az" = "ap-northeast-1a"
		
		}
		
	}

variable "public2" {
    type = "map"
    default = {
        "name" = "redis-pub2c"
        "cidr" = "10.0.1.0/24"
        "az" = "ap-northeast-1c"

		}

	}


variable "private1" {
    type = "map"
    default = {
        "name" = "redis-priv1a"
        "cidr" = "10.0.2.0/24"
        "az" = "ap-northeast-1a"
    }
}


variable "private2" {
    type = "map"
    default = {
        "name" = "redis-priv2c"
        "cidr" = "10.0.3.0/24"
        "az" = "ap-northeast-1c"
    }
}


