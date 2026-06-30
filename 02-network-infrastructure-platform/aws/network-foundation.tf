# AWS network foundation for Project 02.
# Configure the AWS provider before applying.

resource "aws_vpc" "enterprise" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "enterprise-network-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.enterprise.id
  cidr_block              = "10.20.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = { Name = "enterprise-public-subnet" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.enterprise.id
  cidr_block        = "10.20.2.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "enterprise-private-subnet" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.enterprise.id
  tags = { Name = "enterprise-igw" }
}
