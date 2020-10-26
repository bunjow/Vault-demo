provider "vault" {
  address = "https://vault.bunjow.com"
}

data "vault_generic_secret" "WebappUser" {
  path = "mydb/webapp"
}

