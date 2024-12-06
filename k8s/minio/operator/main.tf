resource "helm_release" "minio_operator" {
  name              = "minio-operator"
  chart             = "operator"
  repository        = "https://operator.min.io/"
  namespace         = var.namespace
  dependency_update = "true"
  version           = "6.0.4"
}