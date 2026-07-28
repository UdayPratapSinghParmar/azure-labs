res_grp = {
  rg1 = {
    name       = "rg_1"
    location   = "eastus"
    managed_by = "terraform"
  }

  rg2 = {
    name       = "rg_2"
    location   = "eastus"
    managed_by = "gcp"
  }
}


virt_net = {
  iana1_vnet = {
    location            = "eastus"
    resource_group_name = "rg_1"
    address_space       = ["10.0.0.0/16"]
  }

  # iana2_vnet = {
  #   location            = "westus"
  #   resource_group_name = "rg_2"
  #   address_space       = ["19.0.0.0/16"]
  # }
}


subnetdev = {
    subnet_frontend = {
        resource_group_name = "rg_1"
        virtual_network_name = "iana1_vnet"
        address_prefixes = ["10.0.1.0/24"]

    }

    subnet_backend = {
        resource_group_name = "rg_1"
        virtual_network_name = "iana1_vnet"
        address_prefixes = ["10.0.2.0/24"]

    }

    # subnet_db = {
    #     resource_group_name = "rg_1"
    #     virtual_network_name = "iana1_vnet"
    #     address_prefixes = ["10.0.3.0/24"]

    # }

  }


  
nics = {
 
  nic1 ={
  name                = "frontend_nic"
  location            = "eastus"
  resource_group_name = "rg_1"
  virtual_network_name = "iana1_vnet"
  subnet = "subnet_frontend"
  pip1 = "frontend_pip"
  }

  nic2 ={
  name                = "backend_nic"
  location            = "eastus"
  resource_group_name = "rg_1"
  virtual_network_name = "iana1_vnet"
  subnet = "subnet_backend"
  pip2 = "backend_pip"
  }

}


public_ips = {
  pip1 = {
    public_ip_name = "pip-frotend"
    resource_group_name = "rg1"
    location = "eastus"
    allocation_method = "static"

  }
  pip2 = {
    public_ip_name = "pip-backend"
    resource_group_name = "rg1"
    location = "eastus"
    allocation_method = "static"

  }
}



vms = {
  vm_abc = {
  name                  = "Frontend_vm"
  location              = "eastus"
  resource_group_name   = "rg_1"
  nic_subnet_name = "subnet_frontend"
  nic_vnet_name = "iana1_vnet"
  nic_pip_name = "frontend_pip"
  vm_name = "frontend_vm"
  vm_size = "Standard_D4_v5"
  admin_username = "devopsadmin"
  admin_password = "Devops@123"
}
}