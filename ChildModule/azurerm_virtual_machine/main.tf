
data "azurerm_network_interface" "nic" {
  name                = "frontendvm_nic"
  resource_group_name = "rg_1"
  location = "westus"
}

data "azurerm_subnet" "subnet" {
  name                 = "frontend_subnet"
  virtual_network_name = "iana1_vnet"
  resource_group_name  = "rg_1"
}

data "azurerm_public_ip" "public_ip" {
  name                = "pip_frontend"
  resource_group_name = "rg_1"
}


resource "azurerm_network_interface" "nics" {
  for_each = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.sub_data1[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip1[each.key].id

  }


}





resource "azurerm_virtual_machine" "main" {
 for_each = var.vms1
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.nics[each.key].id]
  vm_size               = each.value.vm_size
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password


  storage_os_disk {
     name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    
  }
  
}
