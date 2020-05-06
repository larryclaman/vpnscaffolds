# main.tf

terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = ">=2.8.0"
  features {}
}


resource "azurerm_resource_group" "test" {
  name     = "peeredvnets-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "hub" {
  name                = "hub"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.1.0.0/16"]
  location            = "East US"
  
}

resource "azurerm_subnet" "hubsub1" {
  name                 = "hubsub1"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.10.0/24"]
}


resource "azurerm_subnet" "hubgw" {
  name                 = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.1.1.0/24"]
}


resource "azurerm_virtual_network" "spokea" {
  name                = "spokea"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.2.0.0/16"]
  location            = "East US"
}


resource "azurerm_subnet" "Asub1" {
  name                 = "Asub1"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.spokea.name
  address_prefixes     = ["10.2.10.0/24"]
}


resource "azurerm_subnet" "spokeagw" {
  name                 = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.spokea.name
  address_prefixes     = ["10.2.1.0/24"]
}




resource "azurerm_virtual_network" "spokeb" {
  name                = "spokeb"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.3.0.0/16"]
  location            = "East US"
}

resource "azurerm_subnet" "Bsub1" {
  name                 = "Bsub1"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.spokeb.name
  address_prefixes     = ["10.3.10.0/24"]
}


resource "azurerm_subnet" "spokebgw" {
  name                 = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.spokeb.name
  address_prefixes     = ["10.3.1.0/24"]
}

##### VNET C #####


resource "azurerm_virtual_network" "vnetc" {
  name                = "vnetc"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.4.0.0/16"]
  location            = "East US"
}

resource "azurerm_subnet" "Csub1" {
  name                 = "csub1"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.vnetc.name
  address_prefixes     = ["10.4.10.0/24"]
}


resource "azurerm_subnet" "vnetbgw" {
  name                 = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.vnetc.name
  address_prefixes     = ["10.4.1.0/24"]
}

########


resource "azurerm_virtual_network" "onprem" {
  name                = "onprem"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.100.0.0/16"]
  location            = "East US"
}

resource "azurerm_subnet" "onpremsub1" {
  name                 = "onpremsub1"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.onprem.name
  address_prefixes     = ["10.100.10.0/24"]
}


resource "azurerm_subnet" "onpremsubgw" {
  name                 = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.onprem.name
  address_prefixes     = ["10.100.1.0/24"]
}