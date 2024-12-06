resource "kubernetes_namespace" "minio" {
  metadata {
    name = var.namespace

    labels = {
      app = var.namespace
    }
  }
}