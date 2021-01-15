resource "kubernetes_deployment" "windows_server_iis" {
  metadata {
    name      = "windows-server-iis"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name

  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app   = "windows-server-iis"
        tier  = "backend"
        track = "stable"
      }
    }

    template {
      metadata {
        labels = {
          app   = "windows-server-iis"
          tier  = "backend"
          track = "stable"
        }
      }

      spec {
        volume {
          name = "appd-dotnet-agent"
        }

        init_container {
          name    = "micro-dotnet-agent"
          image   = "appdynamics/dotnet-agent:20.6.0-micro"
          command = ["pwsh", "-command", "copy-item -path c:/appdynamics/dotnet-agent/* -destination c:/appd-dotnet-agent -Recurse"]

          volume_mount {
            name       = "appd-dotnet-agent"
            mount_path = "c:/appd-dotnet-agent"
          }
        }

        container {
          name  = "windows-server-iis"
          image = "mcr.microsoft.com/dotnet/framework/samples:aspnetapp"

          port {
            name           = "http"
            container_port = 80
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.agent_config.metadata.0.name
            }
          }

          env {
            name = "APPDYNAMICS.AGENT.ACCOUNTACCESSKEY"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.controller.metadata.0.name
                key  = kubernetes_secret.controller.metadata.0.labels.name
              }
            }
          }

          env {
            name  = "APPDYNAMICS.AGENT.APPLICATIONNAME"
            value = var.APPDYNAMICS_AGENT_APPLICATION_NAME
          }

          env {
            name  = "APPDYNAMICS_AGENT_TIER_NAME"
            value = var.APPDYNAMICS_AGENT_TIER_NAME
          }

          env {
            name = "APPDYNAMICS_AGENT_NODE_NAME"

            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name = "APPDYNAMICS_AGENT_UNIQUE_HOST_ID"

            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }

          volume_mount {
            name       = "appd-dotnet-agent"
            mount_path = "c:/appdynamics/dotnet-agent"
          }

          image_pull_policy = "IfNotPresent"
        }

        node_selector = {
          "kubernetes.io/os" = "windows"
        }
      }
    }
  }
}

resource "kubernetes_service" "front_end" {
  metadata {
    name      = "front-end"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 80
      target_port = "80"
    }

    selector = {
      app   = "windows-server-iis"
      tier  = "backend"
      track = "stable"
    }

    type             = "NodePort"
    session_affinity = "None"
  }
}

