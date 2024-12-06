resource "kubernetes_secret" "minio_secret" {
  metadata {
    name      = "minio-secret"
    namespace = var.namespace
  }

  data = {
    accesskey = var.access_key
    secretkey = var.secret_key
  }

  type = "Opaque"
}