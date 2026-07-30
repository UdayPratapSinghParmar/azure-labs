
data "azurerm_network_interface" "nic" {
  for_each =  var.nics
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
}

data "azurerm_subnet" "subnets" {
  for_each = var.nics
  name                 = each.value.nic_subnet_name
  virtual_network_name = each.value.nic_vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pips" {
  name                = each.value.nic_pip_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_network_interface" "nics" {
  for_each = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnets[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pips[each.key].id

  }


}





resource "azurerm_virtual_machine" "main" {
 for_each = var.vms1
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.nics[each.key].id]
  vm_size               = each.value.vm_size

  os_profile {
    computer_name  = "hostname"
    admin_username = each.value.admin_username1
    admin_password = each.value.admin_password1
  }
  

  storage_os_disk {
     name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    
  }
  
}
