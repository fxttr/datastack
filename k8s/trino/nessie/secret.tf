resource "kubernetes_secret" "nessie_postgres_creds" {
  metadata {
    name      = "nessie-postgres-creds"
    namespace = "trino"
  }

  data = {
    postgres_username = var.postgres_user
    postgres_password = var.postgres_password
  }

  type = "Opaque"
}
