resource "kubernetes_service_account" "main" {
  metadata {
    name      = var.service_account
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

}

