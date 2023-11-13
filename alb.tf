# Create an Application Load Balancer (ALB)
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.apache-sg.id]

  enable_deletion_protection = false

  subnet_mapping {
    subnet_id = aws_default_subnet.subnet1.id 
  }
  subnet_mapping {
    subnet_id = aws_default_subnet.subnet2.id 
  }
}

# Create a target group for the ALB
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_security_group.apache-sg.vpc_id

  health_check {
    path = "/"
  }
}

# Create a listener for the ALB
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type     = "text/plain"
      status_code      = "200"
      message_body     = "OK"
  }
  }
}

# Register the EC2 instance with the target group
resource "aws_lb_target_group_attachment" "my_target_group_attachment_1" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.ec2_apache_1.id
}

# Register the EC2 instance with the target group
resource "aws_lb_target_group_attachment" "my_target_group_attachment_2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.ec2_apache_2.id
}

# Create a listener rule to forward traffic to the target group
resource "aws_lb_listener_rule" "my_listener_rule" {
  listener_arn = aws_lb_listener.my_listener.arn

  action {
    type            = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
    }
  
  condition {
    path_pattern {
      values = ["/"]
    }
  }
}


output "arn" {
  description = "The ARN of the load balancer."
  value       = aws_lb.my_alb.arn
}