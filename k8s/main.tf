module "trino" {
  source = "./trino"
}

module "clickhouse" {
  source = "./clickhouse"
  clickhouse_cluster_password = "D__246!dLnM"
}

module "dagster" {
  source = "./dagster"
}

module "kafka" {
  source = "./kafka"
}

module "spark" {
  source = "./spark"
}