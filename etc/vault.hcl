storage "file" {
  path    = "/vault-db"
}

ui = true
listener "tcp" {
  address     = "127.0.0.1:8300"
#  tls_cert_file = "/etc/vault/server.crt"
#  tls_key_file  = "/etc/vault/server.key"
   tls_disable = 1
}
log_level = "debug"
disable_mlock = true
