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
  tags = {
    Name = "IGW"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab_gw.id
}

resource "aws_subnet" "subnet_pbl1" {
  cidr_block        = "192.168.0.0/24"
  vpc_id            = aws_vpc.devops_lab_final.id
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "subnet_pbl2" {
  cidr_block        = "192.168.1.0/24"
  vpc_id            = aws_vpc.devops_lab_final.id
  availability_zone = "eu-central-1c"

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.devops_lab_final.id
  tags = {
    Name = "Public RT"
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.subnet_pbl1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.subnet_pbl2.id
  route_table_id = aws_route_table.public_rt.id
}



//resource "aws_internet_gateway" "lab_gw" {
//  vpc_id = aws_vpc.devops_lab_final.id
//  tags = {
//    Name = "devops-lab-gw"
//  }
//}
//
//
//resource "aws_route_table" "public-rt" {
//  vpc_id = aws_vpc.devops_lab_final.id
//
//  tags = {
//    Name = "jenkins-sn"
//  }
//}
//
//resource "aws_route" "public_route" {
//  route_table_id = aws_vpc.devops_lab_final.default_route_table_id
//  destination_cidr_block = "0.0.0.0/0"
//  gateway_id = aws_internet_gateway.lab_gw.id
//}
//
//resource "aws_subnet" "jenkins-sn" {
//  cidr_block = "192.168.1.0/24"
//  vpc_id = aws_vpc.devops_lab_final.id
//  availability_zone = "eu-central-1c"
//
//  tags = {
//    Name = "jenkins-sn"
//  }
//}
//resource "aws_route_table_association" "a1" {
//  subnet_id = aws_subnet.jenkins-sn.id
//  route_table_id = aws_route_table.rt.id
//}


//
//resource "aws_subnet" "petclinic-sn" {
//  cidr_block        = "192.168.2.0/24"
//  vpc_id            = aws_vpc.devops_lab_final.id
//  availability_zone = "eu-central-1b"
//
//  tags = {
//    Name = "petclinic-sn"
//  }
//}




//resource "aws_route_table_association" "a2" {
//  subnet_id = aws_subnet.petclinic-sn.id
//  route_table_id = aws_route_table.rt.id
//}