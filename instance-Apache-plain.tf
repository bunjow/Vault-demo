resource "aws_instance" "PlainApache" {
  ##  ami           = var.AMIS[var.AWS_REGION]
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  #  vpc_security_group_ids =  ["aws_security_group.home-access.id","aws_security_group.allow-mariadb.id"]
  vpc_security_group_ids = [aws_security_group.allow-mariadb.id, aws_security_group.home-access.id]

  tags = {
    Name = "Apache Plain"
    Role = "Web"
  }

  provisioner "file" {
    source      = "Scripts/apache-plain.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

  ##  provisioner "file" {
  ##    source      = "Scripts/mysql-client.sh"
  ##    destination = "/tmp/mysql-client.sh"
  ##  }
  ##  provisioner "remote-exec" {
  ##    inline = [
  ##      "chmod +x /tmp/mysql-client.sh",
  ##      "sudo /tmp/mysql-client.sh",
  ##    ]
  ##  }
  ##
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

output "PlainApache" {
  value = aws_instance.PlainApache.public_ip
}
