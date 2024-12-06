resource "kubernetes_manifest" "tenant" {
  manifest = yamldecode(file("${path.module}/yaml/tenant.yaml"))

  depends_on = [
    kubernetes_secret.minio_secret
  ]
}

resource "kubernetes_manifest" "create_bucket" {
  manifest = yamldecode(file("${path.module}/yaml/bucket.yaml"))

  depends_on = [
    kubernetes_manifest.tenant
  ]
}
