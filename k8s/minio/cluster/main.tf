resource "kubernetes_manifest" "minio_tenant" {
  manifest = {
    apiVersion = "minio.min.io/v2"
    kind       = "Tenant"
    metadata = {
      name      = "minio"
      namespace = var.namespace
      labels = {
        app = "minio"
      }
    }
    spec = {
      credsSecret = {
        name = "minio-secret"
      }
      image            = "minio/minio:latest"
      imagePullPolicy  = "IfNotPresent"
      pools = [
        {
          name      = "pool-0"
          resources = {
            requests = {
              cpu    = "1"
              memory = "2Gi"
            }
          }
          servers = 1
          volumeClaimTemplate = {
            metadata = {
              name = "data"
            }
            spec = {
              accessModes = ["ReadWriteOnce"]
              resources = {
                requests = {
                  storage = "5Gi"
                }
              }
              storageClassName = "standard"
            }
          }
          volumesPerServer = 4
        }
      ]
      requestAutoCert = false
      users = [
        {
          name = "storage-user-0"
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "minio_bucket" {
  manifest = {
    apiVersion = "batch/v1"
    kind       = "Job"
    metadata = {
      name      = "create-bucket"
      namespace = var.namespace
    }
    spec = {
      template = {
        spec = {
          containers = [
            {
              name    = "createbucket"
              image   = "amazon/aws-cli"
              command = ["aws"]
              args    = [
                "s3api",
                "create-bucket",
                "--bucket",
                "postgres",
                "--endpoint-url",
                "http://minio:80"
              ]
              env = [
                {
                  name = "AWS_ACCESS_KEY_ID"
                  valueFrom = {
                    secretKeyRef = {
                      name = "minio-secret"
                      key  = "accesskey"
                    }
                  }
                },
                {
                  name = "AWS_SECRET_ACCESS_KEY"
                  valueFrom = {
                    secretKeyRef = {
                      name = "minio-secret"
                      key  = "secretkey"
                    }
                  }
                }
              ]
            }
          ]
          restartPolicy = "Never"
        }
      }
      backoffLimit = 1
    }
  }
}
