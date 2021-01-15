resource "kubernetes_deployment" "deployment_client_api" {
  metadata {
    name      = "client-api"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
    labels = {
      name = "client-api"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "client-api"
      }
    }

    template {
      metadata {
        labels = {
          name = "client-api"
        }
      }

      spec {
        volume {
          name = "appd-agent-repo-java"
        }

        volume {
          name = "appd-volume"
        }

        init_container {
          name    = "appd-agent-attach"
          image   = "docker.io/appdynamics/java-agent:latest"
          command = ["cp", "-ra", "/opt/appdynamics/.", "/opt/temp"]

          volume_mount {
            name       = "appd-agent-repo-java"
            mount_path = "/opt/temp"
          }

          termination_message_path = "/dev/termination-log"
          image_pull_policy        = "Always"
        }

        container {
          name  = "client-api"
          image = "sashaz/java-services:v5"

          port {
            container_port = 8080
            protocol       = "TCP"
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.agent_config.metadata.0.name

            }
          }

          env {
            name  = "APPDYNAMICS_AGENT_APPLICATION_NAME"
            value = var.APPDYNAMICS_AGENT_APPLICATION_NAME
          }

          env {
            name  = "APPDYNAMICS_AGENT_TIER_NAME"
            value = var.APPDYNAMICS_AGENT_TIER_NAME
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
            name  = "JAVA_OPTS"
            value = " -Dappdynamics.agent.accountAccessKey=$(APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY) -Dappdynamics.controller.hostName=$(APPDYNAMICS_CONTROLLER_HOST_NAME) -Dappdynamics.controller.port=$(APPDYNAMICS_CONTROLLER_PORT) -Dappdynamics.controller.ssl.enabled=$(APPDYNAMICS_CONTROLLER_SSL_ENABLED) -Dappdynamics.agent.accountName=$(APPDYNAMICS_AGENT_ACCOUNT_NAME) -Dappdynamics.agent.applicationName=$(APPDYNAMICS_AGENT_APPLICATION_NAME) -Dappdynamics.agent.tierName=$(APPDYNAMICS_AGENT_TIER_NAME) -Dappdynamics.agent.reuse.nodeName=true -Dappdynamics.agent.reuse.nodeName.prefix=$(APPDYNAMICS_AGENT_REUSE_NODE_NAME_PREFIX) -javaagent:/opt/appdynamics-java/javaagent.jar "
          }

          volume_mount {
            name       = "appd-agent-repo-java"
            mount_path = "/opt/appdynamics-java"
          }

          volume_mount {
            name       = "appd-volume"
            mount_path = "/opt/appdlogs"
          }

          image_pull_policy = "IfNotPresent"

          #security_context {
          #  run_as_user  = 1000
          #  run_as_group = 3000
          #}
        }

        restart_policy       = "Always"
        dns_policy           = "ClusterFirst"
        service_account_name = kubernetes_service_account.main.metadata.0.name
      }
    }
  }
}

resource "kubernetes_service" "service_client_api" {
  metadata {
    name      = "client-api"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  spec {
    port {
      name        = "8080"
      port        = 8080
      target_port = 8080
    }

    selector = {
      name = kubernetes_deployment.deployment_client_api.metadata.0.name
    }
  }

}