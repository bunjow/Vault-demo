path "mydb/webapp" {
  capabilities = ["create", "update", "read", "delete"]
}
path "*" {
  capabilities = ["list"]
}

# Additional access for UI
path "mydb/metadata" {
  capabilities = ["list"]
}
