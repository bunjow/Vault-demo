
provider "vault" {
 address = "https://vault.bunjow.com"
# skip_tls_verify=true
#  auth_token = "${data.vault_generic_secret.db_auth.data["Name"]}"
}

data "vault_generic_secret" "RootUser" {
 path = "mydb/root"
}

