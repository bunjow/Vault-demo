data "template_file" "dbinfo-init" {
  template = file("Scripts/make-dbino.inc.sh")
  vars = {
    DBPassword = data.vault_generic_secret.RootUser.data["Password"]
    DBUserName = data.vault_generic_secret.RootUser.data["UserName"]
    DBDatabase = data.vault_generic_secret.RootUser.data["Database"]
    DBSever = data.vault_generic_secret.RootUser.data["Server"]
  }
}

data "template_db_config" "dbinfo-inc" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.dbinfo-init.rendered
  }
}

