resource "aws_instance" "DemoApache" {
  ##  ami           = var.AMIS[var.AWS_REGION]
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.allow-mariadb.id, aws_security_group.home-access.id]

  tags = {
    Name = "Apache Demo"
    Role = "Web"
  }
  #
  ## Use data-dbinfo.tf to provision dbinfo.inc here: 
  #
  user_data = data.template_cloudinit_config.db_info.rendered
  #
  ## Install Apache, PHP, MySQl
  #
  provisioner "file" {
    source      = "Scripts/apache-demo.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
  #
  ## Install index.php
  #
  provisioner "file" {
    source      = "Files/ShowTable.php"
    destination = "/tmp/ShowTable.php"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/ShowTable.php /var/www/html/index.php",
      "sudo rm /var/www/html/index.html",
    ]
  }
  #
  ## set up SSH connection to provision
  #
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}
#
## Create DNS record
#
resource "aws_route53_record" "DemoApache-record" {
  zone_id         = aws_route53_zone.bunjow.zone_id
  name            = "demo.bunjow.com"
  type            = "CNAME"
  ttl             = "120"
  allow_overwrite = true
  records         = [aws_instance.DemoApache.public_ip]
}

## OUTPUTS
output "DemoApache" {
  value = aws_instance.DemoApache.public_ip
}
