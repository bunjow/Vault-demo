data "template_file" "db_inc" {
  template = file("Scripts/make-dbinfo.inc.sh")
  vars = {
    DBPassword = data.vault_generic_secret.RootUser.data["Password"]
    DBUserName = data.vault_generic_secret.RootUser.data["UserName"]
    DBDatabase = data.vault_generic_secret.RootUser.data["Database"]
    DBServer = data.vault_generic_secret.RootUser.data["Server"]
  }
}

data "template_cloudinit_config" "db_info" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "/tmp/dbinfo.inc"
    content_type = "text/x-shellscript"
    content      = data.template_file.db_inc.rendered
  }
}
