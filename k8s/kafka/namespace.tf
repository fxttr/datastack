resource "kubernetes_namespace" "kafka" {
  metadata {
    name = "kafka"

    labels = {
      app = "kafka"
    }
  }
}