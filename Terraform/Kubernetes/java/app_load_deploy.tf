
resource "kubernetes_deployment" "app_load" {

  metadata {
    name      = "app-load"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "app-load"
      }
    }

    template {
      metadata {
        labels = {
          name = "app-load"
        }
      }

      spec {
        container {
          image             = "sashaz/app-load:v1"
          image_pull_policy = "IfNotPresent"
          name              = "app-load"

        }

        restart_policy = "Always"
      }
    }
  }

}