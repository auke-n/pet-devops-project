resource "aws_vpc" "devops_lab_final" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops-lab-vpc"
  }
}

resource "aws_internet_gateway" "lab_gw" {
  vpc_id = aws_vpc.devops_lab_final.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_vpc.devops_lab_final.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab_gw.id
}

resource "aws_subnet" "pet-clinic-sn" {
  cidr_block        = "192.168.1.0/24"
  vpc_id            = aws_vpc.devops_lab_final.id
  availability_zone = "eu-central-1c"

  tags = {
    Name = "Pet-clinic SN"
  }
}

resource "aws_subnet" "private_reserve" {
  cidr_block        = "192.168.2.0/24"
  vpc_id            = aws_vpc.devops_lab_final.id
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Private-rsrv"
  }
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.devops_lab_final.id
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.private_reserve.id
  route_table_id = aws_route_table.private_rt.id
}
