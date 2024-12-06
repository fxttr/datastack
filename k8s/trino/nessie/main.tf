resource "helm_release" "nessie" {
    name       = "nessie"
    chart      = "nessie"
    repository = "https://charts.projectnessie.org"
    namespace = "trino"
  
    values = [
        yamlencode({
        versionStoreType = "JDBC"
        jdbc = {
            jdbcUrl = "jdbc:postgresql://nessie-postgres.trino.svc.cluster.local:5432/${var.postgres_db}?currentSchema=nessie"
            secret = {
                name     = "nessie-postgres-creds"
                username = "postgres_username"
                password = "postgres_password"
            }
        }
        })
    ]
}