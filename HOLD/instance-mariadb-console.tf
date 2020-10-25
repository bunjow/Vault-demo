resource "aws_instance" "mariadb-console" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
#  subnet_id     = aws_subnet.matt-pub-c.id
  # the security group to grant 3306 access
 # vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
  vpc_security_group_ids =  [aws_security_group.home-access.id]
  tags = {
    Name = "MariadbConsole"
    Role = "Console"
  }
  provisioner "file" {
    source      = "Scripts/mysql-client.sh"
    destination = "/tmp/mysql-client.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/mysql-client.sh",
      "sudo /tmp/mysql-client.sh",
    ]
  }
##  provisioner "file" {
##    source      = "Scripts/awscli.sh"
##    destination = "/tmp/awscli.sh"
##  }
##  provisioner "remote-exec" {
##    inline = [
##      "chmod +x /tmp/awscli.sh",
##      "sudo /tmp/awscli.sh",
##    ]
##  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

output "MariadbConsole" {
  value = aws_instance.mariadb-console.public_ip
}
