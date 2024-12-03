resource "kubernetes_namespace" "clickhouse" {
  metadata {
    name = "clickhouse"

    labels = {
      app = "clickhouse"
    }
  }
}