variable "clickhouse_cluster_name" {
  description = "Name of the ClickHouse cluster"
  default     = "warehouse"
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

variable "clickhouse_cluster_shards" {
  description = "Number of shards"
  type = number
  default = 1
}

variable "clickhouse_cluster_replicas" {
  description = "Number of replicas"
  type = number
  default = 1
}

variable "clickhouse_cluster_memory_limit" {
  description = "Memory limit in GiB for the ClickHouse cluster"
  type = number
  default = 8
}

variable "clickhouse_cluster_cpu_limit" {
  description = "CPU limit for the ClickHouse cluster"
  type = number
  default = 4
}

variable "clickhouse_cluster_storage_amount" {
  description = "Request amount for ClickHouse cluster storage"
  type = number
  default = 80
}