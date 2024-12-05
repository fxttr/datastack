resource "kubernetes_namespace" "clickhouse" {
  metadata {
    name = var.namespace

    labels = {
      app = var.namespace
    }
  }
}