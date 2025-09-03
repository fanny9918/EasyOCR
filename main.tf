tphardening@tphardening-virtual-machine:~/terraform$ cat main.tf
# Définition du fournisseur AWS
provider "aws" {
 region = "us-east-1" # Remplacez par votre région AWS
}
# Création du VPC
resource "aws_vpc" "mon_vpc" {
 cidr_block = "10.0.0.0/16"
 enable_dns_support = true
 enable_dns_hostnames = true
 tags = {
 Name = "mon-vpc"
 }
}
# Création du sous-réseau public
resource "aws_subnet" "subnet_public" {
 vpc_id = aws_vpc.mon_vpc.id
 cidr_block = "10.0.1.0/24"
 map_public_ip_on_launch = true
 availability_zone = "us-east-1a" # Remplacez selon votre région
 tags = {
 Name = "subnet-public"
 }
}
# Création du sous-réseau privé
resource "aws_subnet" "subnet_prive" {
 vpc_id = aws_vpc.mon_vpc.id
 cidr_block = "10.0.2.0/24"
 availability_zone = "us-east-1b" # Remplacez selon votre région
 tags = {
 Name = "subnet-prive"
 }
}
# Création de la passerelle Internet
resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.mon_vpc.id
 tags = {
 Name = "internet-gateway"
 }
}
# Création de la table de routage
resource "aws_route_table" "route_table" {
 vpc_id = aws_vpc.mon_vpc.id
 route {
 cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.gw.id
 }
 tags = {
 Name = "route-table"
 }
}
# Association de la table de routage au sous-réseau public
resource "aws_route_table_association" "assoc_public" {
 subnet_id = aws_subnet.subnet_public.id
 route_table_id = aws_route_table.route_table.id
}
# Création d'une instance EC2 dans le sous-réseau public
resource "aws_instance" "mon_instance" {
 ami = "ami-0360c520857e3138f" # AMI Ubuntu, à adapter selon votre région
 instance_type = "t2.micro"
 subnet_id = aws_subnet.subnet_public.id
 tags = {
 Name = "mon-instance-stephanie"
 }
}
