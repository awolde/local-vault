resource "vault_jwt_auth_backend" "gcp_oidc" {
  description        = "Login with your Gmail Account"
  path               = "goidc"
  type               = "oidc"
  oidc_discovery_url = "https://accounts.google.com"
  oidc_client_id     = var.client_id 
  oidc_client_secret = var.client_secret
  default_role       = "gmail"
  tune {
    listing_visibility = "unauth"
    default_lease_ttl  = "768h"
    max_lease_ttl      = "768h"
    token_type         = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "gmail" {
  backend        = vault_jwt_auth_backend.gcp_oidc.path
  role_name      = "gmail"
  token_policies = ["home-policy"]

  bound_audiences = [var.client_id]
  user_claim      = "sub"
  bound_claims = {
    sub = var.gmail_ids # allow only specific users to login, otherwise anyone with gmail can login
  }
  role_type = "oidc"
  allowed_redirect_uris = ["https://localhost:8250/oidc/callback", "https://localhost:8200/ui/vault/auth/goidc/oidc/callback", "https://pub.${var.domain}:8250/oidc/callback", "https://pub.${var.domain}:8200/ui/vault/auth/goidc/oidc/callback"]
  verbose_oidc_logging  = true
}

variable "domain" {}
variable "gmail_ids" {}
variable "client_id" {}
variable "client_secret" {}

resource "vault_policy" "home_policy" {
  name = "home-policy"

  policy = <<EOT
    path "kv/*" {
      capabilities = [ "create", "read", "update", "delete", "list"]
    }
    path "auth/-/*/token/*" {
      capabilities = [ "read" ]
    }
EOT
}

resource "vault_mount" "kv" {
  path = "kv"
  type = "kv-v2"
}
