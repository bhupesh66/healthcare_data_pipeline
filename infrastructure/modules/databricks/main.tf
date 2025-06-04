resource "azurerm_databricks_workspace" "this" {
  name                = "dbx-${var.env}"
  resource_group_name = var.resource_group
  location            = "northeurope"
  sku                 = "premium"
}

resource "databricks_cluster" "this" {
  cluster_name            = "cluster-${var.env}"
  spark_version           = "13.3.x-scala2.12"
  node_type_id            = var.cluster_config.node_type_id
  autotermination_minutes = var.cluster_config.auto_terminate_minutes
}