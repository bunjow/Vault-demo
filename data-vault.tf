
provider "vault" {
  address = "https://vault.bunjow.com"
# address = "https://vault.example.net:8200"
}

data "vault_generic_secret" "WebappUser" {
  path = "mydb/webapp"
}

