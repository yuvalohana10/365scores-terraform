
resource "aws_security_group" "allow-internet" {
    vpc_id = aws_vpc.main.id
    name = "allow-internet"
    description = "Security group that allows ports 80 and 443 and all egress traffic"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"                # change to -1 to allow all protocols 
        cidr_blocks = ["0.0.0.0/0"]      # change this into my IP address to make it more restrictive 
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-internet"
    }
}