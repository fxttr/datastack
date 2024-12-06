resource "kubernetes_persistent_volume" "nessie_postgres_volume" {
  metadata {
    name = "nessie-postgres-volume"
    labels = {
        type = "local"
        app  = "nessie-postgres"
    }
  }

  spec {
    storage_class_name = "manual"

    capacity = {
      storage = "10Gi"
    }

    access_modes = ["ReadWriteMany"]

    persistent_volume_source {
        host_path {
            path = "/var/mnt/nessie/postgresql"
        }
    }
  }
}
