resource "aws_security_group" "allow-ssh-home" {
  name        = "allow-ssh-home"
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

resource "aws_security_group" "allow-mariadb" {
#  vpc_id      = aws_vpc.main.id
  name        = "allow-mariadb"
  description = "allow-mariadb"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.allow-ssh-home.id] # allowing access from our example instance
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "allow-mariadb"
  }
}
