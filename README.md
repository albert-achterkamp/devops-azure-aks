# DevOPS - Initial State - Terraform/Azure

Requirements:

- The Azure Account created
- The Service Principal set up
- Set the variables (used security variables to make the repo be cleaner) to be used across the commands (used in the github actions)
  - For Azure CLI
    - AZURE_CREDENTIALS
  - For Terraform CLI
    - AZURE_CLIENT_ID
    - AZURE_CLIENT_SECRET
    - AZURE_SUBSCRIPTION_ID
    - AZURE_TENANT_ID
- Initial state - resources must exists before. Using as dependency the repository https://github.com/timoteosoutello/devops-azure-initial-terraform-state

## CI/CD

Using Github actions, it was created the following YML files:

- az-terraform-create-cluster.yml
  - The Terraform State:
    - 
  - The Cluster:
- az-terraform-destroy-cluster.yml

## Kubernetes Cluster

Getting credentials for kubernetes

```
az aks get-credentials --resource-group {{resource_group_name}} --name {{kubernetes_cluster_name}};
```

# References

**Microsoft**

- https://docs.microsoft.com/en-us/azure/aks

**Terraform**

- https://github.com/hashicorp/learn-terraform-provision-aks-cluster
- https://learn.hashicorp.com/tutorials/terraform/aks?in=terraform/kubernetes
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
- https://docs.microsoft.com/pt-br/azure/aks/scale-cluster
- https://docs.microsoft.com/pt-br/azure/virtual-machines/sizes
- https://azure.microsoft.com/pt-br/pricing/details/virtual-machines/series/
- https://docs.microsoft.com/pt-br/azure/virtual-machines/sizes-general
- https://azure.microsoft.com/pt-br/blog/new-av2-series-vm-sizes/

**External references**

- 