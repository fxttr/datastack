#module "trino" {
#  source = "./trino"
#}

module "clickhouse" {
  source = "./clickhouse"
  cluster_replicas = 2
  cluster_shards = 2
  cluster_user = data.sops_file.clickhouse.data["user"]
  cluster_password = data.sops_file.clickhouse.data["password"]
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