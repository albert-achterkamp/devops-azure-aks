# AKS Cluster
cluster_dns_prefix="aks-test"
cluster_name="aks-cluster"

# AKS Nodes
cluster_node_count=1
cluster_node_name="aksclusternm"
cluster_node_os_disk_size=30
# Check SKU in https://docs.microsoft.com/pt-br/azure/virtual-machines/sizes-general
cluster_node_vm_size="Standard_A2_v2"

# Others
region="brazilsouth"
resource_group_name="rg-azure-aks"

# Tag control
tag_component="aks_component"
tag_environment="dev"
tag_name="aks_cluster"