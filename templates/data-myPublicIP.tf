data "template_file"  "myPublicIP" {
	template = "${file("templates/whatismyip.sh")}"

	vars {
		myip = "${aws_instance.database1.private_ip}"
	}
}
