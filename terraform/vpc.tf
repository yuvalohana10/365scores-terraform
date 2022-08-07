resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "main"
    }
}

#subnets
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-1a"

    tags = {
        Name = "public-subnet"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-1a"

    tags = {
        Name = "private-subnet"
    }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-gw"
    }
}

# route tables
resource "aws_route_table" "public_routetable" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }
    
    tags = {
        Name = "public_routetable"
    }
}

# route associations public
resource "aws_route_table_association" "public_routeassociation" {
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public_routetable.id
}