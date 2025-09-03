tphardening@tphardening-virtual-machine:~/terraform$ cat variables.tf
variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "bucket_name" {
  default = "my-log-bucket-stephanie"
}

variable "desired_capacity" {
  default = 2
}

variable "max_size" {
  default = 4
}

variable "min_size" {
  default = 1
}
