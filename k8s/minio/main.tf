module "operator" {
  source = "./operator"
  namespace = var.namespace
}

module "cluster" {
  depends_on = [ module.operator ]
  source = "./cluster"
  namespace = var.namespace
  access_key = var.access_key
  secret_key = var.secret_key
}