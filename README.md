# DevOPS - Initial State - Terraform/Azure

Requirements:

- The Azure Account created
- The Service Principal set up
- Set the variables (used security variables to make the repo be cleaner) to be used across the commands (used in the github actions)
  - For Azure CLI
    - AZURE_CREDENTIALS
  - For Terraform CLI
    - For authentication
      - AZURE_CLIENT_ID
      - AZURE_CLIENT_SECRET
      - AZURE_SUBSCRIPTION_ID
      - AZURE_TENANT_ID
    - For backend state
      - RESOURCE_GROUP_NAME
      - STORAGE_ACCOUNT_NAME
      - STORAGE_CONTAINER_NAME
- Initial state - resources must exists before. Using as dependency the repository https://github.com/timoteosoutello/devops-azure-initial-terraform-state

## CI/CD

Using Github actions, it was created the following YML files:

- az-terraform-create-cluster.yml
  - The Terraform State:
    - ![](documentation\images\state.png)
  - The Cluster:
    - ![](documentation\images\k8s.png)
- az-terraform-destroy-cluster.yml

## Configure kubectl

To configure kubetcl run the following command:

```shell
$ az aks get-credentials --resource-group {{resource_group_name}} --name {{kubernetes_cluster_name}}
```

Outcome should be:

```shell
$ Merged {{kubernetes_cluster_name}} as current context in {{LOCAL_DIR}}\.kube\config
```
## Configure Kubernetes Dashboard

To use the Kubernetes dashboard, we need to create a `ClusterRoleBinding`. This
gives the `cluster-admin` permission to access the `kubernetes-dashboard`.

```shell
$ kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard  --user=clusterUser
```

Finally, to access the Kubernetes dashboard, run the following command:

```shell
$ az aks browse --resource-group {{resource_group_name}} --name {{kubernetes_cluster_name}}
```

You should be able to access the Kubernetes dashboard at [http://127.0.0.1:8001/](http://127.0.0.1:8001/).

Login with kubectl config

![](documentation\images\aks_kube_config_login.png)

# References

**Microsoft**

- https://docs.microsoft.com/en-us/azure/aks
- https://docs.microsoft.com/pt-br/azure/aks/scale-cluster
- https://docs.microsoft.com/pt-br/azure/virtual-machines/sizes
- https://azure.microsoft.com/pt-br/pricing/details/virtual-machines/series/
- https://docs.microsoft.com/pt-br/azure/virtual-machines/sizes-general
- https://azure.microsoft.com/pt-br/blog/new-av2-series-vm-sizes/

**Terraform**

- https://github.com/hashicorp/learn-terraform-provision-aks-cluster
- https://learn.hashicorp.com/tutorials/terraform/aks?in=terraform/kubernetes
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
- https://github.com/hashicorp/learn-terraform-provision-aks-cluster

**External references**

- https://build5nines.com/terraform-create-an-aks-cluster/