resource "kubernetes_deployment" "dotnet_app" {
  metadata {
    name      = "dotnet-app"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name

  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "dotnet-app"
      }
    }

    template {
      metadata {
        labels = {
          name = "dotnet-app"
        }
      }

      spec {
        volume {
          name = "appd-agent-repo"
        }

        init_container {
          name    = "appd-agent"
          image   = "appdynamics/dotnet-core-agent:4.5.19"
          command = ["cp", "-ra", "/opt/appdynamics/.", "/opt/appd"]

          volume_mount {
            name       = "appd-agent-repo"
            mount_path = "/opt/appd"
          }

          image_pull_policy = "Always"
        }

        container {
          name  = "dotnet-app"
          image = "microsoft/dotnet-samples:aspnetapp"

          port {
            container_port = 80
          }

          env {
            name  = "APPDYNAMICS_AGENT_APPLICATION_NAME"
            value = var.APPDYNAMICS_AGENT_APPLICATION_NAME
          }

          env {
            name  = "APPDYNAMICS_AGENT_TIER_NAME"
            value = var.APPDYNAMICS_AGENT_TIER_NAME
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.agent_config.metadata.0.name

            }
          }

          env {
            name = "APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.controller.metadata.0.name
                key  = kubernetes_secret.controller.metadata.0.labels.name
              }
            }
          }

          volume_mount {
            name       = "appd-agent-repo"
            mount_path = "/opt/appd"
          }

          image_pull_policy = "IfNotPresent"
        }

        restart_policy       = "Always"
        service_account_name = kubernetes_service_account.main.metadata.0.name
      }
    }
  }
}

resource "kubernetes_service" "dotnet_app" {
  metadata {
    name      = "dotnet-app"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name

  }

  spec {
    port {
      name        = "80"
      port        = 80
      target_port = "80"
    }

    selector = {
      name = kubernetes_deployment.dotnet_app.metadata.0.name
    }

    type = "NodePort"
  }
}

