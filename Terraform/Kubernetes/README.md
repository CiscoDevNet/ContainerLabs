# Terraform Kubernetes Deployment

These examples contain HarshipCorp Configuration Language (HCL)  deployment files for Kubernetes

## Controller Key

Create an environment variable on the Terraform host machine  

export TF_VAR_APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=xxxx

## Kubernetes Cluster

Modify the main.tf file to connect to k8s cluster. 

```yaml
provider "kubernetes" {
  config_context = "my-context"
}
```

The example below uses minikube cluster: 

```yaml 

provider "kubernetes" {
  config_context     = "minikube"
  load_config_file   = "false"
  host               = "https://192.168.99.128:8443" # k cluster-info 
  insecure           = "true"
  client_certificate = file("~/.minikube/profiles/minikube/client.crt")
  client_key         = file("~/.minikube/profiles/minikube/client.key")

}

```

Please refer to the docs for further details -
 https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs

## Run 

cd into the java or dotnetcore and run these commands in sequence: 

`terraform init` 

`terraform plan`

`terraform apply`

