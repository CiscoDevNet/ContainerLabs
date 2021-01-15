provider "kubernetes" {
  config_context     = "minikube"
  load_config_file   = "false"
  host               = "https://192.168.99.128:8443" # k cluster-info 
  insecure           = "true"
  client_certificate = file("~/.minikube/profiles/minikube/client.crt")
  client_key         = file("~/.minikube/profiles/minikube/client.key")

}

resource "kubernetes_namespace" "custom_ns" {
  metadata {
    annotations = {
      name = "appdynamics-ns"
    }
    name = var.custom_namespace
  }
}

output "ns_name" {
  value = kubernetes_namespace.custom_ns.metadata.0.name
}

resource "kubernetes_secret" "controller" {
  metadata {
    name      = "cluster-agent-secret"
    namespace = kubernetes_namespace.custom_ns.metadata.0.name #creates implicit dependency... otherwise, explicit depends_on is required
    labels = {
      name = "controller-key" # This label must be the same as the data.controller-key below. 
    }
  }
  #export TF_VAR_APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=xxxx
  data = {
    controller-key = var.APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY
  }
}

