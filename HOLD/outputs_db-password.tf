output "DBUserName" {
  value = data.vault_generic_secret.WebappUser.data["UserName"]
}

##output "DBPassword" {
##  value = data.vault_generic_secret.WebappUser.data["Password"]
##}

##output "MyDBInfo" {
##  value = data.template_file.db_inc.rendered
##}
