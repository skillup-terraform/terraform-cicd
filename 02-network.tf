resource "azurerm_resource_group" "terra_rg" {
  location = "eastus"
  name = "terrafrom_resource_rg_01"
  tags = {
    Name = "team"
    Environment = "DEV"
  }
}  

resource "azurerm_public_ip" "public_ip" {
  name                = "terraPublicIp1"
  resource_group_name = azurerm_resource_group.terra_rg.name
  location            = azurerm_resource_group.terra_rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "name" {
  name = "terrasubnet"
  resource_group_name = azurerm_resource_group.terra_rg.name
  virtual_network_name = azurerm_virtual_network.terra_vm_network.name
  address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_virtual_network" "terra_vm_network" {
  name = "terra_vm_network_01"
  resource_group_name = azurerm_resource_group.terra_rg.name
  address_space = [ "10.0.0.0/16" ]
  location = azurerm_resource_group.terra_rg.location
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.terra_rg.location
  resource_group_name = azurerm_resource_group.terra_rg.name

  ip_configuration {
    name = "sur-01"
    subnet_id = azurerm_subnet.name.id
    private_ip_address_allocation = "Dynamic"
    primary = true
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  ip_configuration {
    name = "sur-02"
    subnet_id = azurerm_subnet.name.id
    private_ip_address_allocation = "Dynamic"
    primary = false
  }

}

resource "azurerm_network_security_group" "terra_nsg" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.terra_rg.location
  resource_group_name = azurerm_resource_group.terra_rg.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

 security_rule {
    name                       = "xyz"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
  
}

resource "azurerm_network_interface_security_group_association" "name" {
  network_interface_id = azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.terra_nsg.id
}