resource "aws_instance" "PlainNginx" {
  ##  ami           = var.AMIS[var.AWS_REGION]
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids =  [aws_security_group.home-access.id]
  tags = {
    Name = "Nginx Plain"
    Role = "Web"
  }
  provisioner "file" {
    source      = "Scripts/nginx-plain.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

output "PlainNginx" {
  value = aws_instance.PlainNginx.public_ip
}
