module "clickhouse_operator" {
  count      = var.install_operator ? 1 : 0
  source     = "./operator"

  clickhouse_operator_namespace = var.namespace
  clickhouse_operator_version   = var.operator_version
}

module "clickhouse_cluster" {
  depends_on = [module.clickhouse_operator]
  count      = var.install_cluster ? 1 : 0
  source     = "./cluster"

  clickhouse_cluster_name = var.cluster_name
  clickhouse_cluster_namespace = var.namespace
  clickhouse_cluster_password = var.cluster_password
  clickhouse_cluster_user = var.cluster_user
  clickhouse_cluster_shards = var.cluster_shards
  clickhouse_cluster_replicas = var.cluster_replicas
  clickhouse_cluster_cpu_limit = var.cluster_cpu_limit
  clickhouse_cluster_memory_limit = var.cluster_memory_limit
  clickhouse_cluster_storage_amount = var.cluster_storage_amount
}