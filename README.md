<img src="https://static-00.iconduck.com/assets.00/terraform-icon-1803x2048-hodrzd3t.png" alt="Terraform Logo" align="right" height="227" width="200"/>

# Terraform Modules - _Hetzner Cloud_

Terraform modules for [_Hetzner Cloud_](https://www.hetzner.com/). They allow you to rapidly to loads of things 
within _Hetzner Cloud_ including, but not limited to:

* Create and configure **compute** instances and automate initial server setup with _cloud-config_
* Manage **block-storage** volumes and attach/detach them from compute instances
* Configure Cloud **firewalls** and to assign them to compute instances
* Create **private networks**, seamlessly divide them into subnets and configure **routes**

---

### ⚡️ Usage

We included [examples](examples/) for each module to showcase larger more complex configurations, however the basic 
steps to begin using these modules is to modify the `source` property inside the module block and either point it the 
public GitHub repository URL or the [Terraform registry](https://registry.terraform.io/) source address. This also allows for module-local changes 
within larger Terraform modules, enabling incremental adoption. For more information refer to the [Terraform 
documentation](https://developer.hashicorp.com/terraform/language/modules/sources).

```hcl
module "hetzner_server_apache" {
  source = "git::https://github.com/fmjstudios/terraform-modules-hetzner.git//modules/compute"

  name = "example_server-1"
  ...
}
```

### 🧩 Modules

| Module                                               | Description                                                                               |
|------------------------------------------------------|-------------------------------------------------------------------------------------------|
| [compute](modules/compute/README.md)                 | Create server configured with [_cloud-init_](https://cloudinit.readthedocs.io/en/latest/) |
| [private-network](modules/private-network/README.md) | Create private networks plus contained subnets                                            |
| [firewall](modules/firewall/README.md)               | Create firewalls and assign them compute instances                                        |
| [block-storage](modules/block-storage/README.md)     | Create block storage volumes and attach them to compute instances                         |
| [rdns](modules/rdns/README.md)                       | Manage rDNS records                                                                       |
| [placement-group](modules/placement-group/README.md) | Adjust and assign compute instance placement groups                                       |

### 💬 Contributing

Contributions are always welcome. Please be sure to follow our Guidelines:
* [**Contributing**](docs/CONTRIBUTING.md)
* [**Code of Conduct**](docs/CODE_OF_CONDUCT.md)

__TBA__

### 📜 License

Copyright ©️ 2023, FMJ Studios and/or its associates.
This software is licensed under the [MIT License](LICENSE).