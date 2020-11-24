# DevOPS - Initial State - Terraform/Azure

Requirements:

- The Azure Account created
- The Service Principal set up and Initial state in place. 
  - Using as dependency the repository https://github.com/timoteosoutello/devops-azure-initial-terraform-state for this step
- Set the variables to make the repo be cleaner
  - For Azure CLI
    - AZURE_CREDENTIALS
  - For Terraform CLI (used in CI/CD Tools)
    - For authentication
      - AZURE_CLIENT_ID
      - AZURE_CLIENT_SECRET
      - AZURE_SUBSCRIPTION_ID
      - AZURE_TENANT_ID
    - For backend state
      - RESOURCE_GROUP_NAME
      - STORAGE_ACCOUNT_NAME
      - STORAGE_CONTAINER_NAME

## CI/CD

Using **Github actions** (.github/workflows/) or **Azure DevOps** (cicd/azure-dev-ops) it was created the following YML files:

- The az-terraform-create-cluster.yml - For resources creation
  - After the creation, result would be like below
    - The Terraform State:
      - ![](documentation\images\state.png)
    - The Cluster:
      - ![](documentation\images\k8s.png)
- The az-terraform-destroy-cluster.yml  - For resources destruction

### CI/CD Troubleshoot

Common errors:

- Error building ARM Config: obtain subscription() from Azure CLI: Error parsing json result from the Azure CLI: Error waiting for the Azure CLI: exit status 1
  - **Solution:** Ensure that you passed the correct AZURE variables as mentioned above
- A task is missing. The pipeline references a task called 'TerraformInstaller'. This usually indicates the task isn't installed, and you may be able to install it from the Marketplace: https://marketplace.visualstudio.com. (Task version 0, job 'prepare', step ''.)
  - **Solution**: Install the [terraform extension](https://dev.azure.com/tsoutello/test/_build/results?buildId=11&view=logs&j=cebb7365-f209-590e-ea23-03f1fba8144c&t=b876e2e3-4bf8-5afc-1e94-654150d48086&l=12) for your Azure Dev Ops account.

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
- Terraform examples
  - https://docs.microsoft.com/en-us/azure/developer/terraform/create-k8s-cluster-with-tf-and-aks
  - https://docs.microsoft.com/en-us/azure/developer/terraform/create-k8s-cluster-with-aks-applicationgateway-ingress
- Azure DevOps
  - https://github.com/microsoft/azure-pipelines-extensions/tree/master/Extensions/Terraform/Src/Tasks/TerraformTaskV1

**Terraform**

- https://github.com/hashicorp/learn-terraform-provision-aks-cluster
- https://learn.hashicorp.com/tutorials/terraform/aks?in=terraform/kubernetes
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
- https://github.com/hashicorp/learn-terraform-provision-aks-cluster

**External references**

- https://build5nines.com/terraform-create-an-aks-cluster/
- https://itnext.io/infrastructure-as-code-iac-with-terraform-azure-devops-f8cd022a3341
- https://itnext.io/managing-azure-rbac-roles-and-assignments-with-terraform-1a1cdb2f8eb6