locals {
  env_name = "hc-${var.git_sha}-${var.env_type}" # hc-a1b2c3-dev
}

resource "azurerm_resource_group" "this" {
  name     = local.env_name
  location = "northeurope"
  tags = {
    auto_destroy = "true"  # Marks for cleanup
  }
}

module "databricks" {
  source = "../../modules/databricks"
  
  env            = local.env_name
  resource_group = azurerm_resource_group.this.name
  cluster_config = {
    node_type_id  = var.env_type == "dev" ? "Standard_D4s_v3" : "Standard_D8s_v3"
    auto_terminate_minutes = 10  # Auto-kill after 1h idle
  }
}