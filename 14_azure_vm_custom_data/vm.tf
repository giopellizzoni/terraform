resource "azurerm_resource_group" "resource_group" {
  name     = "rg-vm"
  location = var.location

  tags = local.common_tags
}


resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-gp"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = local.common_tags
}

resource "azurerm_network_interface" "network_interface" {
  name                = "nic-gp"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "public-ip-gp"
    subnet_id                     = data.terraform_remote_state.vnet.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "nisga" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = data.terraform_remote_state.vnet.outputs.security_group_id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-gp"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.network_interface.id]
  size                  = "Standard_B1s"
  custom_data           = base64encode(file("./docs/docker.sh"))
  admin_username        = "giopellizzoni"

  admin_ssh_key {
    username   = "giopellizzoni"
    public_key = file("~/.ssh/azure-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = local.common_tags
}


