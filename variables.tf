variable "aws_region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "terraform-demo-keeth"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ami" {
  default = "ami-020cba7c55df1f615" # change this to proper ami id 
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "sub1_cidr" {
  default = "10.0.0.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}