variable "postgres_db" {
  description = "Database name for the nessie PostgresDB"
  type        = string
  default     = "nessie"
}

variable "postgres_user" {
  description = "Database user for the nessie PostgresDB"
  type        = string
  default     = "nessie"
}

variable "postgres_password" {
  description = "Database password for the nessie PostgresDB"
  type        = string
  default     = null
}