resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = azurerm_resource_group.resource_group_aks.location
  resource_group_name = azurerm_resource_group.resource_group_aks.name
  dns_prefix          = var.cluster_dns_prefix
  tags                = local.default_tags

  default_node_pool {
    name            = var.cluster_node_name
    node_count      = var.cluster_node_count
    vm_size         = var.cluster_node_vm_size
    os_disk_size_gb = var.cluster_node_os_disk_size
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    kube_dashboard {
      enabled = true
    }
  }

  identity {
    type = "SystemAssigned"
  }
}