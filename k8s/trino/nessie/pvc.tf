resource "kubernetes_persistent_volume_claim" "nessie_postgres_volume_claim" {
  metadata {
    name = "nessie-postgres-volume-claim"
    namespace = "trino"
    labels = {
        app = "nessie-postgres"
    }
  }

  spec {
    storage_class_name = "manual"

    access_modes = ["ReadWriteMany"]

    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}
