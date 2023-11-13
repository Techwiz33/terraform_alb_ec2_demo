resource "aws_instance" "ec2_apache_2" {

  ami = "ami-05fa00d4c63e32376"
  instance_type = var.instance_type
  key_name = var.ec2_ssh_keypair
  vpc_security_group_ids = [aws_security_group.apache-sg.id]
  subnet_id = aws_default_subnet.subnet2.id
  associate_public_ip_address = true

  user_data = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd.x86_64
  sudo systemctl start httpd.service
  sudo systemctl enable httpd.service
  echo “Hello World from $(hostname -f) -v1” | sudo tee /var/www/html/index.html
  EOF
  tags = {
    Name = "ec2ec2_apache_2_apache"

  }
}

output "ec2_Apache_2_IPAddress" {
  value = "${aws_instance.ec2_apache_2.public_ip}"
}