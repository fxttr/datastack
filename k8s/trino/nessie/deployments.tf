resource "kubernetes_deployment" "nessie_postgres" {
  metadata {
    name = "nessie-postgres"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nessie-postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "nessie-postgres"
        }
      }

      spec {
        container {
          name  = "nessie-postgres"
          image = "postgres:17"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 5432
          }

          env_from {
            config_map_ref {
              name = "postgres-secret"
            }
          }

          volume_mount {
            name       = "postgresdata"
            mount_path = "/var/lib/postgresql/data"
          }
        }

        volume {
          name = "postgresdata"

          persistent_volume_claim {
            claim_name = "postgres-volume-claim"
          }
        }
      }
    }
  }
}
