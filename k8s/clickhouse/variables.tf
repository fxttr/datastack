variable "install_cluster" {
  description = "Enable the installation of the ClickHouse cluster"
  type        = bool
  default     = true
}

variable "install_operator" {
  description = "Enable the installation of the Altinity Kubernetes operator for ClickHouse"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Namespace for the ClickHouse cluster"
  default     = "clickhouse"
  type        = string
}

variable "operator_version" {
  description = "Version of the Altinity Kubernetes operator for ClickHouse"
  default     = "0.23.4"
  type        = string
}

variable "cluster_name" {
  description = "Name of the ClickHouse cluster"
  default     = "warehouse"
  type        = string
}

variable "cluster_user" {
  description = "ClickHouse user"
  default     = "test"
  type        = string
}

variable "cluster_password" {
  description = "ClickHouse password"
  type        = string
  default     = null
}
variable "cluster_shards" {
  description = "Number of shards"
  type = number
  default = 1
}

variable "cluster_replicas" {
  description = "Number of replicas"
  type = number
  default = 1
}

variable "cluster_memory_limit" {
  description = "Memory limit in GiB for the ClickHouse cluster"
  type = number
  default = 8
}

variable "cluster_cpu_limit" {
  description = "CPU limit for the ClickHouse cluster"
  type = number
  default = 4
}

variable "cluster_storage_amount" {
  description = "Request amount for ClickHouse cluster storage"
  type = number
  default = 80
}