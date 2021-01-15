resource "kubernetes_config_map" "agent_config" {
  metadata {
    name      = "dotnetcore-agent-config"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  data = {
    APPDYNAMICS_AGENT_ACCOUNT_NAME           = var.APPDYNAMICS_AGENT_ACCOUNT_NAME
    APPDYNAMICS_AGENT_REUSE_NODE_NAME_PREFIX = var.APPDYNAMICS_AGENT_REUSE_NODE_NAME_PREFIX
    APPDYNAMICS_CONTROLLER_HOST_NAME         = var.APPDYNAMICS_CONTROLLER_HOST_NAME
    APPDYNAMICS_CONTROLLER_PORT              = var.APPDYNAMICS_CONTROLLER_PORT
    APPDYNAMICS_CONTROLLER_SSL_ENABLED       = var.APPDYNAMICS_CONTROLLER_SSL_ENABLED
    APPDYNAMICS_EVENTS_API_URL               = var.APPDYNAMICS_EVENTS_API_URL
    APPDYNAMICS_GLOBAL_ACCOUNT_NAME          = var.APPDYNAMICS_GLOBAL_ACCOUNT_NAME
    APPDYNAMICS_AGENT_REUSE_NODE_NAME        = true
    CORECLR_ENABLE_PROFILING                 = "1"
    CORECLR_PROFILER                         = "{57e1aa68-2229-41aa-9931-a6e93bbc64d8}"
    CORECLR_PROFILER_PATH                    = "/opt/appd/libappdprofiler.so"
  }
}
