resource "kubernetes_config_map" "nessie_postgres_secret" {
  metadata {
    name      = "postgres-secret"
    labels = {
      app = "nessie-postgres"
    }
  }

  data = {
    POSTGRES_DB       = var.postgres_db
    POSTGRES_USER     = var.postgres_user
    POSTGRES_PASSWORD = var.postgres_password
  }
}
