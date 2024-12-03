resource "kubernetes_namespace" "dagster" {
  metadata {
    name = "dagster"

    labels = {
      app = "dagster"
    }
  }
}