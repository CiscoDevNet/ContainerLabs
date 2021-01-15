resource "kubernetes_config_map" "analytics_agent_config" {
  metadata {
    name      = "analytics-agent-config"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  data = {
    EVENT_ENDPOINT                        = var.APPDYNAMICS_EVENTS_API_URL
    APPDYNAMICS_CONTROLLER_PORT           = var.APPDYNAMICS_CONTROLLER_PORT
    APPDYNAMICS_CONTROLLER_HOST_NAME      = var.APPDYNAMICS_CONTROLLER_HOST_NAME
    APPDYNAMICS_AGENT_GLOBAL_ACCOUNT_NAME = var.APPDYNAMICS_GLOBAL_ACCOUNT_NAME
    APPDYNAMICS_AGENT_ACCOUNT_NAME        = var.APPDYNAMICS_AGENT_ACCOUNT_NAME
    APPDYNAMICS_CONTROLLER_SSL_ENABLED    = var.APPDYNAMICS_CONTROLLER_SSL_ENABLED
  }
}
