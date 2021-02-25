resource "aws_security_group" "container_webapp_sg"{
    name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.container_webapp_vpc.id

  ingress {
    description = "HTTPS user access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "HTTP user access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-sg",var.PROJECT_NAME)
    Project = var.PROJECT_NAME
    Env = var.ENVIRONMENT
  }
}