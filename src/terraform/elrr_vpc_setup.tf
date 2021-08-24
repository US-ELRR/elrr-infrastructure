# Terraform will use provider stated below
provider "aws" {
  region = "us-east-2"
}

# Create ELRR VPC in us-east-2
resource "aws_vpc" "elrr_vpc" {
  provider             = aws
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "elrr_vpc"
  }
}

# Create IGW in us-east-2
resource "aws_internet_gateway" "elrr_igw" {
  provider = aws
  vpc_id   = aws_vpc.elrr_vpc.id

  tags = {
    Name = "elrr_igw"
  }
}

# Get all available AZ's in VPC for elrr
data "aws_availability_zones" "elrr-azs" {
  provider = aws
  state    = "available"
}

# Create public route table in us-east-2
resource "aws_route_table" "elrr_public_route_table" {
  provider = aws
  vpc_id   = aws_vpc.elrr_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.elrr_igw.id
  }
  tags = {
    Name = "elrr_public_route_table"
  }
}

resource "aws_route_table_association" "elrr_public_rt1" {
  subnet_id      = aws_subnet.elrr_public_subnet_1.id
  route_table_id = aws_route_table.elrr_public_route_table.id
}

resource "aws_route_table_association" "elrr_public_rt2" {
  subnet_id      = aws_subnet.elrr_public_subnet_2.id
  route_table_id = aws_route_table.elrr_public_route_table.id
}

# Create private route table 1 in us-east-2
resource "aws_route_table" "elrr_private_route_table1" {
  provider = aws
  vpc_id   = aws_vpc.elrr_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.elrr_nat_gateway1.id
  }
  tags = {
    Name = "elrr_private_route_table1"
  }
}

# Create private route table 2 in us-east-2
resource "aws_route_table" "elrr_private_route_table2" {
  provider = aws
  vpc_id   = aws_vpc.elrr_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.elrr_nat_gateway2.id
  }
  tags = {
    Name = "elrr_private_route_table2"
  }
}

resource "aws_route_table_association" "elrr_private_rt1" {
  subnet_id      = aws_subnet.elrr_private_subnet_1.id
  route_table_id = aws_route_table.elrr_private_route_table1.id
}

resource "aws_route_table_association" "elrr_private_rt2" {
  subnet_id      = aws_subnet.elrr_private_subnet_2.id
  route_table_id = aws_route_table.elrr_private_route_table2.id
}

resource "aws_eip" "elrr_nat_gw_eip1" {
  vpc      = true

  tags     = {
    Name = "elrr_nat_gw_eip1"
    }
}

resource "aws_eip" "elrr_nat_gw_eip2" {
  vpc      = true

  tags     = {
    Name = "elrr_nat_gw_eip2"
    }
}

resource "aws_nat_gateway" "elrr_nat_gateway1" {
  allocation_id = aws_eip.elrr_nat_gw_eip1.id
  subnet_id     = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_nat_gateway1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.elrr_igw]
}

resource "aws_nat_gateway" "elrr_nat_gateway2" {
  allocation_id = aws_eip.elrr_nat_gw_eip2.id
  subnet_id     = aws_subnet.elrr_public_subnet_2.id

  tags = {
    Name = "elrr_nat_gateway2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.elrr_igw]
}

# Create subnet in us-east-2
resource "aws_subnet" "elrr_public_subnet_1" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 0)
  vpc_id            = aws_vpc.elrr_vpc.id
  cidr_block        = "10.0.6.0/24"

  tags = {
    Name = "elrr_public_subnet_1"
  }
}

# Create subnet in us-east-2
resource "aws_subnet" "elrr_public_subnet_2" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 1)
  vpc_id            = aws_vpc.elrr_vpc.id
  cidr_block        = "10.0.8.0/24"

  tags = {
    Name = "elrr_public_subnet_2"
  }
}

# Create subnet in us-east-2
resource "aws_subnet" "elrr_private_subnet_1" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 2)
  vpc_id            = aws_vpc.elrr_vpc.id
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "elrr_private_subnet_1"
  }
}

# Create subnet in us-east-2
resource "aws_subnet" "elrr_private_subnet_2" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 3)
  vpc_id            = aws_vpc.elrr_vpc.id
  cidr_block        = "10.0.12.0/24"

  tags = {
    Name = "elrr_private_subnet_2"
  }
}
