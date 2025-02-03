resource "aws_subnet" "web-pub-sub-1a" {
  vpc_id                  = aws_vpc.web-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.web-igw]

  tags = {
    Name = "Terraform-Public-1-Subnet"
  }
}

resource "aws_subnet" "web-pub-sub-1b" {
  vpc_id                  = aws_vpc.web-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.web-igw]

  tags = {
    Name = "Terraform-Public-2-Subnet"
  }
}

resource "aws_subnet" "web-prv-sub-1a" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  depends_on = [aws_internet_gateway.web-igw]

  tags = {
    Name = "Terraform-Private-3-Subnet"
  }
}

resource "aws_subnet" "web-prv-sub-1b" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  depends_on = [aws_internet_gateway.web-igw]

  tags = {
    Name = "Terraform-Private-4-Subnet"
  }
}
