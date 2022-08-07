resource "aws_instance" "my-instance" {
    ami = var.ami
    instance_type = var.instance_type

    # the VPC subnet
    subnet_id = aws_subnet.public-subnet.id
    
    #the security group
    vpc_security_group_ids = [aws_security_group.allow-internet.id]

    # the public SSH key
    key_name = aws_key_pair.mykeypair.key_name
}