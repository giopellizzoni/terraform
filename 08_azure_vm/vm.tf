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

resource "azurerm_virtual_machine" "vm" {
  name                  = "vm-gp"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.network_interface.id]
  vm_size               = "Standard_B1s"


  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-gp"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "gio-ubuntu"
    admin_username = "giopellizzoni"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/giopellizzoni/.ssh/authorized_keys"
      key_data = file("~/.ssh/azure-key.pub")
    }
  }

  tags = local.common_tags
}
