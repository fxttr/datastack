resource "helm_release" "nessie" {
  name       = "nessie"
  chart      = "nessie"
  repository = "https://charts.projectnessie.org"
  
  values = [
    yamlencode({
      versionStoreType = "JDBC"
      jdbc = {
        jdbcUrl = "jdbc:postgresql://postgres:5432/${var.postgres_db}?currentSchema=nessie"
        secret = {
          name     = "postgres-creds"
          username = "${var.postgres_user}"
          password = "${var.postgres_password}"
        }
      }
    })
  ]
}