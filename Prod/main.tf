module "resource_group" {
  source = "../../ChildModule/azurerm_resource_group"
  rgs    = var.res_grp
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../ChildModule/azurerm_virtual_network"
  vnet       = var.virt_net
}


module "subnet" {
  depends_on = [module.resource_group, module.virtual_network]
  source     = "../../ChildModule/azurerm_subnet"
  subnet     = var.subnetdev
}

module "virtual_machine" {
  depends_on = [module.resource_group, module.azurerm_network_interface]
  source     = "../../ChildModule/azurerm_virtual_machine"
  vms1 = var.vms
}