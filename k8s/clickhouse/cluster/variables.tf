################################################################################
# ClickHouse Cluster
################################################################################
variable "clickhouse_name" {
  description = "Name of the ClickHouse release"
  default     = ""
  type        = string
}

variable "clickhouse_cluster_name" {
  description = "Name of the ClickHouse cluster"
  default     = "warehouse"
  type        = string
}

variable "clickhouse_cluster_chart_version" {
  description = "Version of the ClickHouse cluster helm chart version"
  default     = "0.1.5"
  type        = string
}

variable "clickhouse_keeper_chart_version" {
  description = "Version of the ClickHouse Keeper cluster helm chart version"
  default     = "0.1.5"
  type        = string
}

variable "clickhouse_cluster_namespace" {
  description = "Namespace for the ClickHouse cluster"
  default     = "clickhouse"
  type        = string
}

variable "clickhouse_cluster_user" {
  description = "ClickHouse user"
  default     = "default"
  type        = string
}

variable "clickhouse_cluster_password" {
  description = "ClickHouse password"
  type        = string
  default     = null
}

variable "clickhouse_cluster_instance_type" {
  description = "Instance type for node selection"
  type        = string
}

variable "clickhouse_cluster_enable_loadbalancer" {
  description = "Enable waiting for the ClickHouse LoadBalancer to receive a hostname"
  type        = bool
  default     = true
}

################################################################################
# K8S
################################################################################
variable "k8s_availability_zones" {
  description = "The availability zones to deploy the ClickHouse cluster"
  type        = list(string)
}

variable "k8s_cluster_endpoint" {
  description = "The endpoint for the Kubernetes cluster"
  type        = string
  default     = ""
}

variable "k8s_cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = ""
}

variable "k8s_cluster_region" {
  description = "The region of the Kubernetes cluster"
  type        = string
  default     = ""
}

variable "k8s_cluster_certificate_authority" {
  description = "The certificate authority data for the Kubernetes cluster"
  type        = string
  default     = ""
}