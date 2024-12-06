variable "namespace" {
  description = "Namespace for the minio cluster"
  default     = "minio"
  type        = string
}

variable "access_key" {
  description = "Access key for minio"
  type        = string
  default     = null
}

variable "secret_key" {
  description = "Secret key for minio"
  type        = string
  default     = null
}