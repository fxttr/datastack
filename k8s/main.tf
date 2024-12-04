module "trino" {
  source = "./trino"
}

module "clickhouse" {
  source = "./clickhouse"
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