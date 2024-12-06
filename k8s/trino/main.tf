module "nessie" {
  source = "./nessie"
  postgres_db = var.nessie_postgres_db
  postgres_user = var.nessie_postgres_user
  postgres_password = var.nessie_postgres_password
}

module "trino" {
  depends_on = [module.nessie]
  source = "./trino"
}