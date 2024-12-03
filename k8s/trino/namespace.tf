resource "kubernetes_namespace" "trino" {
  metadata {
    name = "trino"

    labels = {
      app = "trino"
    }
  }
}