resource "kubernetes_deployment" "resource_checker_service" {
  metadata {
    name      = "resource-checker-service"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name

  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app   = "resource-checker-service"
        tier  = "backend"
        track = "stable"
      }
    }

    template {
      metadata {
        labels = {
          app = "resource-checker-service"

          tier = "backend"

          track = "stable"
        }
      }

      spec {
        volume {
          name = "appd-dotnet-agent"
        }

        volume {
          name = "log-volume"
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
          name  = "resource-checker-service"
          image = "iogbole/console_resouce_checker:initcontainer"

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

          ##### PLEASE READ #########
          # It is recommended to hard code the value of APPDYNAMICS_AGENT_NODE_NAME env if the instrumented (.exe)
          # app is designed and expected to always have 1 replica. For example, <tier_name>_1. 
          # If the instrumented application scales to > 1 replicas, it is recommended to use  dynamic node using 
          # the pod or container information as shown below. Please refer to this doc for further detail. 
          # https://kubernetes.io/docs/tasks/inject-data-application/environment-variable-expose-pod-information/

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

          volume_mount {
            name       = "log-volume"
            mount_path = "c:/resource-check/logs"
          }

          image_pull_policy = "Always"
        }

        container {
          name  = "appd-log-analytics"
          image = "appdynamics/analytics-agent:20.6.0-win"

          port {
            container_port = 9090
            protocol       = "TCP"
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.analytics_agent_config.metadata.0.name

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

          env {
            name  = "APPDYNAMICS_AGENT_APPLICATION_NAME"
            value = "windows|component|application"
          }

          volume_mount {
            name       = "log-volume"
            mount_path = "c:/logdir"
          }

          image_pull_policy = "Always"
        }

        node_selector = {
          "kubernetes.io/os" = "windows"
        }
      }
    }
  }
}

