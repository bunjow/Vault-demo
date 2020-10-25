output "DBUserName" {
 value = data.vault_generic_secret.RootUser.data["UserName"]
}

output "DBPassword" {
 value = data.vault_generic_secret.RootUser.data["Password"]
}
