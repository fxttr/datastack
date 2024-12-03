resource "kubernetes_namespace" "spark" {
  metadata {
    name = "spark"

    labels = {
      app = "spark"
    }
  }
}