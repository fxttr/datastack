resource "kubernetes_manifest" "clickhouse_installation" {
  manifest = {
    "apiVersion" = "clickhouse.altinity.com/v1"
    "kind"       = "ClickHouseInstallation"
    "metadata" = {
      "name"      = var.clickhouse_cluster_name
      "namespace" = var.clickhouse_cluster_namespace
    }
    "spec" = {
      "defaults" = {
        "templates" = {
          "volumeClaimTemplate" = "pvc-template"
        }
      }
      "configuration" = {
        "users" = {
          "${var.clickhouse_cluster_user}/password" = var.clickhouse_cluster_password
          "${var.clickhouse_cluster_user}/networks/ip" = ["0.0.0.0/24"]
        }
        "zookeeper" = {
          "nodes" = [
            { "host" = "zookeeper1.zoo1ns" },
            { "host" = "zookeeper2.zoo1ns" }
          ]
        }
        "clusters" = [
          {
            "name" = "cluster1"
            "layout" = {
              "shardsCount"   = var.clickhouse_cluster_shards
              "replicasCount" = var.clickhouse_cluster_replicas
            }
            "templates" = {
              "podTemplate"         = "clickhouse-template"
              "volumeClaimTemplate" = "pvc-template"
            }
          }
        ]
      }
      "templates" = {
        "podTemplates" = [
          {
            "name" = "clickhouse-template"
            "spec" = {
              "containers" = [
                {
                  "name"  = "clickhouse"
                  "image" = "clickhouse/clickhouse-server:latest"
                  "resources" = {
                    "requests" = {
                      "memory" = "2Gi"
                      "cpu"    = "1"
                    }
                    "limits" = {
                      "memory" = "${var.clickhouse_cluster_memory_limit}Gi"
                      "cpu"    = "${var.clickhouse_cluster_cpu_limit}"
                    }
                  }
                  "volumeMounts" = [
                    {
                      "name"      = "clickhouse-data"
                      "mountPath" = "/var/lib/clickhouse"
                    }
                  ]
                }
              ]
            }
          }
        ]
        "volumeClaimTemplates" = [
          {
            "name" = "pvc-template"
            "spec" = {
              "accessModes" = ["ReadWriteOnce"]
              "resources" = {
                "requests" = {
                  "storage" = "${var.clickhouse_cluster_storage_amount}Gi"
                }
              }
            }
          }
        ]
      }
    }
  }
}
