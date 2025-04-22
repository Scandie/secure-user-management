resource "aws_security_group" "nat_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "NAT-SG"
  }
}

resource "tls_private_key" "nat_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nat_key" {
  key_name   = "nat-key-pair"
  public_key = tls_private_key.nat_key.public_key_openssh
}

resource "local_file" "nat_private_key" {
  content         = tls_private_key.nat_key.private_key_pem
  filename        = "${path.module}/nat-key-pair.pem"
  file_permission = "0400"
}

resource "aws_instance" "nat" {
  ami                         = var.nat_ami
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public["a"].id
  key_name                    = aws_key_pair.nat_key.key_name
  associate_public_ip_address = true

  security_groups = [aws_security_group.nat_sg.id]

  tags = {
    Name = "NAT-Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y iptables-services
              echo 1 > /proc/sys/net/ipv4/ip_forward
              iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
              service iptables save
              EOF
}
