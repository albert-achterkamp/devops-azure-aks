resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
  name                  = var.cluster_node_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = var.cluster_node_vm_size
  node_count            = var.cluster_node_count
  tags                  = local.default_tags
}