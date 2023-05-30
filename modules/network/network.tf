resource "aws_vpc" "k8s-main" {
  cidr_block = var.vpc_data.cidr_block
  tags = {
    "Name" = var.vpc_data.name
  }
}

resource "aws_internet_gateway" "k8s-igw" {
  vpc_id = aws_vpc.k8s-main.id
  tags = {
    "Name" = "Cluster IGW"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.k8s-main.id
  availability_zone = var.public_subnet_1_data.az
  cidr_block        = var.public_subnet_1_data.cidr_block
  tags = {
    "Name"       = "PublicSubnet-1"
    "Resource"   = "Network"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.k8s-main.id
  availability_zone = var.public_subnet_2_data.az
  cidr_block        =  var.public_subnet_2_data.cidr_block
  tags = {
    "Name"       = "PublicSubnet-2"
    "Resource"   = "Network"
  }
}

resource "aws_route_table" "public-subnet-rt" {
  vpc_id = aws_vpc.k8s-main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s-igw.id
  }

  depends_on = [
    aws_internet_gateway.k8s-igw,
    aws_vpc.k8s-main
  ]

  tags = {
    "Name"       = "public-subnet-rt",
    "Resource"   = "Network"
  }
}

resource "aws_main_route_table_association" "main_subnet" {
  vpc_id         = aws_vpc.k8s-main.id
  route_table_id = aws_route_table.public-subnet-rt.id

  depends_on = [
    aws_route_table.public-subnet-rt
  ]
}

resource "aws_route_table_association" "rt_public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-subnet-rt.id
}

resource "aws_route_table_association" "rt_public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public-subnet-rt.id
}



