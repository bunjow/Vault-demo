resource "aws_security_group" "example-instance" {
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "example-instance"
  }
}

resource "aws_security_group" "home-access" {
  name        = "home-access"
  description = "group allow-ssh from home"
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      cidr_blocks = ingress.value
      protocol    = "tcp"
    }
  }
  ##ingress {
  ##  from_port       = 22
  ##  to_port         = 22
  ##  protocol        = "tcp"
  ##  cidr_blocks     = ["192.227.211.172/32"]
  ##  security_groups = [aws_security_group.allow-ssh.id] # allowing access from our example instance
  ##}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "allow_ssh_home"
  }
}
