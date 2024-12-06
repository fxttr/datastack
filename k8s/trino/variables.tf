variable "nessie_postgres_db" {
  description = "Database name for the nessie PostgresDB"
  type        = string
  default     = "nessie"
}

variable "nessie_postgres_user" {
  description = "Database user for the nessie PostgresDB"
  type        = string
  default     = "nessie"
}

variable "nessie_postgres_password" {
  description = "Database password for the nessie PostgresDB"
  type        = string
  default     = null
}

variable "minio_endpoint" {
  description = "Endpoint for minio, responsible for storing the Apache Iceberg tables"
  type        = string
  default     = "192.168.0.201:9000"
}

variable "minio_access_key" {
  description = "Access key for minio, responsible for storing the Apache Iceberg tables"
  type        = string
  default     = null
}

variable "minio_secret_key" {
  description = "Secret key for minio, responsible for storing the Apache Iceberg tables"
  type        = string
  default     = null
}

variable "clickhouse_jdbc_url" {
  description = "JDBC URL for the ClickHouse cluster"
  type        = string
  default     = null
}

variable "clickhouse_user" {
  description = "Username for the ClickHouse cluster"
  type        = string
  default     = "default"
}

variable "clickhouse_password" {
  description = "Password for the ClickHouse cluster"
  type        = string
  default     = null
}

variable "trino_credentials" {
  description = "Credentials for the trino cluster"
  type        = string
  default     = null
}

variable "trino_tls_cert" {
  description = "Certificate for the trino cluster"
  type        = string
  default     = null
}