resource "azurerm_virtual_network_gateway" "hubvpn" {
  name                = "hubvpn"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw2"
  generation = "Generation2"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.hubvpnip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hubgw.id
  }
}

resource "azurerm_public_ip" "hubvpnip" {
  name                = "hubvpnip"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  allocation_method   = "Dynamic"
}


resource "azurerm_virtual_network_gateway" "bvpn" {
  name                = "bvpn"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw2"
  generation = "Generation2"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.bvpnip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.spokebgw.id
  }
}

resource "azurerm_public_ip" "bvpnip" {
  name                = "bvpnip"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  allocation_method   = "Dynamic"
}