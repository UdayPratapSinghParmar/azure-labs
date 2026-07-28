
resource "azurerm_public_ip" "PIP" {
    for_each = var.public_ips
    name = each.value.public_ip_name
    location = each.value.location
    allocation_method = each.value.allocation_method
    resource_group_name = each.value.resource_group_name
       
}