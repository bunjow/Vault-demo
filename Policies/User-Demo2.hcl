path "demo/user2" {
  capabilities = ["create", "update", "read", "delete"]
}
path "*" {
  capabilities = ["list"]
}

# Additional access for UI
path "demo/metadata" {
  capabilities = ["list"]
}
