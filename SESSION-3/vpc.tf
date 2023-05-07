resource "aws_vpc" "main" {
  cidr_block       = var.vpc_addr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "subnet-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_punlic_ip

  tags = {
    Name = "subnet-public"
  }
}

resource "aws_subnet" "subnet-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_private_ip

  tags = {
    Name = "subnet-private"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-main"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.rt_ip
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_eip" "lauto-eip" {

}

resource "aws_nat_gateway" "automated-NAT" {
  allocation_id = aws_eip.lauto-eip.id
  subnet_id     = aws_subnet.subnet-public.id

  tags = {
    Name = "automated-NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.rt_ip
    gateway_id = aws_nat_gateway.automated-NAT.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-rt-association" {
  subnet_id      = aws_subnet.subnet-private.id
  route_table_id = aws_route_table.private-rt.id
}