# VPC
resource "aws_vpc" "Digital-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable-dns-hostnames

  tags = {
    Name = "Digital-vpc"
  }
}

# aws public subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.Digital-vpc.id
  cidr_block        = var.public_subnet_cidr_1
  availability_zone = "eu-west-2a"

  tags = {
    Name = "public-subnet-1"
  }
}


# aws public subnet 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.Digital-vpc.id
  cidr_block        = var.public_subnet_cidr_2
  availability_zone = "eu-west-2b"

  tags = {
    Name = "public-subnet-2"
  }
}


# aws public subnet 3
resource "aws_subnet" "public-subnet-3" {
  vpc_id            = aws_vpc.Digital-vpc.id
  cidr_block        = var.public_subnet_cidr_3
  availability_zone = "eu-west-2c"

  tags = {
    Name = "public-subnet-3"
  }
}


# aws private subnet 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.Digital-vpc.id
  cidr_block        = var.private_subnet_cidr_1
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private-subnet-1"
  }
}


# aws private subnet 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.Digital-vpc.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private-subnet-2"
  }
}


# aws private subnet 3
resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.Digital-vpc.id
  cidr_block        = var.private_subnet_cidr_3
  availability_zone = "eu-west-2c"

  tags = {
    Name = "private-subnet-3"
  }
}

# public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.Digital-vpc.id

  tags = {
    Name = "public-route-table"
  }
}

# private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.Digital-vpc.id

  tags = {
    Name = "private-route-table"
  }
}


# route table association public subnet 1
resource "aws_route_table_association" "public-subnet-1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

# route table association public subnet 2
resource "aws_route_table_association" "public-subnet-2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}


# route table association public subnet 3
resource "aws_route_table_association" "public-subnet-3-association" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public-route-table.id
}


# route table association private subnet 1
resource "aws_route_table_association" "private-subnet-1-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

# route table association private subnet 2
resource "aws_route_table_association" "private-subnet-2-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}


# route table association private subnet 3
resource "aws_route_table_association" "private-subnet-3-association" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}

# EIP for NAT-gate-way
resource "aws_eip" "elastic-ip-for-nat-gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.8"

  tags = {
    Name = "test-EIP"
  }
}

# NAT-gate-way 
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "test-NAT-gw"
  }

   depends_on = [aws_eip.elastic-ip-for-nat-gw]

}
# route for nat gateway
resource "aws_route" "nat-gateway-route" {
  route_table_id              = aws_route_table.private-route-table.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.nat-gw.id
}

# internet gateway for public subnet
resource "aws_internet_gateway" "test-IGW" {
  vpc_id = aws_vpc.Digital-vpc.id

  tags = {
    Name = "test-IGW"
  }
}

# associate the public subnet through the for internet gateway
resource "aws_route" "public-internet-gw-route" {
  route_table_id              = aws_route_table.public-route-table.id
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id                  = aws_internet_gateway.test-IGW.id
} 