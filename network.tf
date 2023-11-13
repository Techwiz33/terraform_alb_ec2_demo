# Get default VPC 
resource "aws_default_vpc" "default" {
}

# Create subnets in two different Availability Zones
resource "aws_default_subnet" "subnet1" {
  availability_zone       = "us-east-1a"
}

# Create subnets in two different Availability Zones
resource "aws_default_subnet" "subnet2" {
  availability_zone       = "us-east-1b"
}
