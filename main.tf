provider "aws" {
    region = "ap-south-2"
}
#creating vpc
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
} 
#creating subnet
resource "aws_subnet" "mysubnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "ap-south-2a"
    map_customer_owned_ip_on_launch = true
    tags = {
        subnet_name = "mysubnet1"
    }
      
    }
    #creating subnet 2
    resource "aws_subnet" "mysubnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "ap-south-2b"
    map_customer_owned_ip_on_launch = true
    tags = {
        subnet_name = "mysubnet2"
    }
      
    }
    #creating internet gateway
    resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    }
    #creating route table
    resource "aws_route_table" "public-route-table" { 
    vpc_id = aws_vpc.myvpc.id
    }
    #creating route
    resource "aws_route" "public-route" {
        route_table_id = aws_route_table.public-route-table.id
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = internet_gateway.myigw.id
    }
    #associating route table with subnet
    resource "aws_route_table_association" "public-subnet-association" {
        subnet_id = aws_subnet.mysubnet.id
        route_table_id = aws_route_table.public-route-table.id
    }
          
        