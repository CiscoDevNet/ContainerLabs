# Cluster Agent


## Cluster agent deployment using helm charts (targeting AWS EKS)

Resources for this approach can be found in a github project [here](https://github.com/observability-as-code-sandbox/appdynamics-terraform-cluster-monitoring).

## Cluster agent deployment using Kubernetes custom resources

The AppDynamics Cluster Agent and the Operator uses a `CustomResourceDefinition` Kubernetes `kind` which is not supported by the Terraform K8s Provider yet.

 [It is in alpha release](https://www.hashicorp.com/blog/deploy-any-resource-with-the-new-kubernetes-provider-for-hashicorp-terraform)

 Customers wanting to deploy the cluster agent and operator will either have to wait for when HashiCorp releases this in GA,  or accept the risk of using the alpha version.
