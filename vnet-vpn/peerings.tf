
resource "azurerm_virtual_network_peering" "hub2A" {
  name                      = "hub2A"
  resource_group_name       = azurerm_resource_group.test.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spokea.id
  allow_gateway_transit = true
  depends_on = [azurerm_virtual_network_gateway.hubvpn]
}

resource "azurerm_virtual_network_peering" "A2hub" {
  name                      = "A2hub"
  resource_group_name       = azurerm_resource_group.test.name
  virtual_network_name      = azurerm_virtual_network.spokea.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  use_remote_gateways = true
  depends_on = [azurerm_virtual_network_gateway.hubvpn]
}
