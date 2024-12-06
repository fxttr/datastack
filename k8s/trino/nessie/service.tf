resource "kubernetes_service" "nessie_postgres" {
  metadata {
    name = "nessie-postgres"
    namespace = "trino"
    labels = {
        app = "nessie-postgres"
    }
  }

  spec {
    type = "NodePort"

    port {
      port        = 5432
      target_port = 5432
    }

    selector = {
      app = "nessie-postgres"
    }
  }
}
