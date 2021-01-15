resource "kubernetes_config_map" "agent_config" {
  metadata {
    name      = "micro-dotnet-agent-config"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name
  }

  data = {
    "APPDYNAMICS.AGENT.ACCOUNTNAME"          = var.APPDYNAMICS_AGENT_ACCOUNT_NAME
    APPDYNAMICS_AGENT_REUSE_NODE_NAME_PREFIX = var.APPDYNAMICS_AGENT_REUSE_NODE_NAME_PREFIX
    "APPDYNAMICS.CONTROLLER.HOSTNAME"        = var.APPDYNAMICS_CONTROLLER_HOST_NAME
    "APPDYNAMICS.CONTROLLER.PORT"            = var.APPDYNAMICS_CONTROLLER_PORT
    "APPDYNAMICS.CONTROLLER.SSL.ENABLED"     = var.APPDYNAMICS_CONTROLLER_SSL_ENABLED
    APPDYNAMICS_AGENT_REUSE_NODE_NAME        = true
    COR_ENABLE_PROFILING : "1"
    COR_PROFILER : "{39AEABC1-56A5-405F-B8E7-C3668490DB4A}"
    COR_PROFILER_PATH_32 : "c:/appdynamics/dotnet-agent/AppDynamics.Profiler_x86.dll"
    COR_PROFILER_PATH_64 : "c:/appdynamics/dotnet-agent/AppDynamics.Profiler_x64.dll"
  }
}

