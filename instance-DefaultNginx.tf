resource "aws_instance" "defaultNginx" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  tags = {
    Name = "defaultNginx"
    Role = "Web"
  }
  provisioner "file" {
    source      = "Scripts/nginx.sh"
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

output "defaultNginxIPS" {
  value = aws_instance.defaultNginx.public_ip
}
