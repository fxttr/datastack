module "clickhouse_operator" {
  count      = var.install_clickhouse_operator ? 1 : 0
  source     = "./clickhouse-operator"

  clickhouse_operator_namespace = var.clickhouse_operator_namespace
  clickhouse_operator_version   = var.clickhouse_operator_version
}

module "clickhouse_cluster" {
  depends_on = [module.clickhouse_operator]
  count      = var.install_clickhouse_cluster ? 1 : 0
  source     = "./clickhouse-cluster"

  clickhouse_cluster_name                = var.clickhouse_cluster_name
  clickhouse_cluster_namespace           = var.clickhouse_cluster_namespace
  clickhouse_cluster_password            = var.clickhouse_cluster_password
  clickhouse_cluster_user                = var.clickhouse_cluster_user
  clickhouse_cluster_instance_type       = var.eks_node_pools[0].instance_type
  clickhouse_cluster_enable_loadbalancer = var.clickhouse_cluster_enable_loadbalancer
  clickhouse_cluster_chart_version       = var.clickhouse_cluster_chart_version
  clickhouse_keeper_chart_version        = var.clickhouse_keeper_chart_version

  k8s_availability_zones            = var.eks_availability_zones
  k8s_cluster_region                = var.eks_region
  k8s_cluster_name                  = var.eks_cluster_name
  k8s_cluster_endpoint              = module.eks_aws.cluster_endpoint
  k8s_cluster_certificate_authority = base64decode(module.eks_aws.cluster_certificate_authority)
}