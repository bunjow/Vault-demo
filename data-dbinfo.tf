#
## Use Vault to get Password, UserName, Database, and Server settings
#
data "template_file" "db_inc" {
  template = file("Scripts/make-dbinfo2.sh")
  vars = {
    DBPassword = data.vault_generic_secret.WebappUser.data["Password"]
    DBUserName = data.vault_generic_secret.WebappUser.data["UserName"]
    DBDatabase = data.vault_generic_secret.WebappUser.data["Database"]
    DBServer   = data.vault_generic_secret.WebappUser.data["Server"]
  }
}
#
## render the db.info template
#
data "template_cloudinit_config" "db_info" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.db_inc.rendered
  }
}
