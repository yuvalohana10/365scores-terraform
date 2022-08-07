resource "aws_elb" "elb-80-443" {
    name = "elb-80-443"
    subnets = [aws_subnet.public-subnet.id]
    security_groups = [aws_security_group.allow-internet.id]
    listener {
        instance_port = 8000
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
    
    /*
    listener {
        instance_port = 8000
        instance_protocol = "http"
        lb_port = 443
        lb_protocol = "https"
        ssl_certificate_id = "arn:aws:acm:eu-west-1:622279194036:certificate/3076d657-d6a5-408b-b8cd-65ccb5e5f03f"
    } */

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:8000/"
        interval = 30
    }
    instances = [aws_instance.my-instance.id]
    cross_zone_load_balancing = true
    connection_draining = true
    connection_draining_timeout = 400
    tags = {
        Name = "elb-80-443"
    }
}