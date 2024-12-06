module "minio" {
  source = "./minio"
  secret_key = data.sops_file.minio.data["secret_key"]
  access_key = data.sops_file.minio.data["access_key"]
}

module "clickhouse" {
  source = "./clickhouse"
  cluster_replicas = 2
  cluster_shards = 2
  cluster_user = data.sops_file.clickhouse.data["user"]
  cluster_password = data.sops_file.clickhouse.data["password"]
}

module "trino" {
  depends_on = [ module.minio, module.clickhouse ]
  source = "./trino"
  trino_credentials = data.sops_file.trino.data["credentials"]
  trino_tls_cert = data.sops_file.trino.data["cert"]
  nessie_postgres_password = data.sops_file.trino.data["nessie_postgres_password"]
  minio_secret_key = data.sops_file.minio.data["secret_key"]
  minio_access_key = data.sops_file.minio.data["access_key"]
}

#module "dagster" {
#  source = "./dagster"
#}

#module "kafka" {
#  source = "./kafka"
#}

#module "spark" {
#  source = "./spark"
#}

terraform {
  required_providers {
    sops = {
      source = "carlpett/sops"
      version = ">=1.1.1"
    }
  }
}