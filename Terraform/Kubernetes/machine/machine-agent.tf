resource "kubernetes_daemonset" "appd_infra_agent" {
  metadata {
    name = "appd-infra-agent"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  spec {
    selector {
      match_labels = {
        name = "appd-infra-agent"
      }
    }

    template {
      metadata {
        labels = {
          name = "appd-infra-agent"
        }
      }

      spec {
        volume {
          name = "ma-log-volume"

          config_map {
            name = kubernetes_config_map.ma_log_config.metadata.0.name
          }
        }

        volume {
          name = "hostroot"

          host_path {
            path = "/"
            type = "Directory"
          }
        }

        volume {
          name = "docker-sock"

          host_path {
            path = "/var/run/docker.sock"
            type = "Socket"
          }
        }

        container {
          name  = "appd-infra-agent"
          image = "appdynamics/machine-agent-analytics:latest"

          port {
            container_port = 9090
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.ma_config.metadata.0.name
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

          resources {
            limits {
              cpu    = "600m"
              memory = "2Gi"
            }

            requests {
              cpu    = "300m"
              memory = "1G"
            }
          }

          volume_mount {
            name       = "ma-log-volume"
            mount_path = "/opt/appdynamics/conf/logging/log4j.xml"
            sub_path   = "log4j.xml"
          }

          volume_mount {
            name       = "hostroot"
            read_only  = true
            mount_path = "/hostroot"
          }

          volume_mount {
            name       = "docker-sock"
            mount_path = "/var/run/docker.sock"
          }

          image_pull_policy = "IfNotPresent"

          security_context {
            privileged = true
          }
        }

        restart_policy       = "Always"
        service_account_name = kubernetes_service_account.appdynamics_infraviz.metadata.0.name
      }
    }
  }
}

resource "kubernetes_service" "appd_infra_agent_service" {
  metadata {
    name = "appd-infra-agent-service"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  spec {
    port {
      name        = "9090"
      port        = 9090
      target_port = "9090"
    }

    selector = {
      name = kubernetes_daemonset.appd_infra_agent.metadata.0.name

    }
  }
}
