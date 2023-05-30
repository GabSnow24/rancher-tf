# Terraform Module for Rancher and K8S Cluster (Using K3S)

This module will apply Terraform code that will deploy a [Rancher instance](https://www.rancher.com) with a [Kubernetes](https://kubernetes.io/pt-br/) cluster running inside using [K3S](https://k3s.io) in [AWS](https://aws.amazon.com/).

Rancher is responsible for manage containerized clusters from inside and outside instance.

It's recomendable to create and secret key before using this module, and pass in module parameters (explained below).

## Quick start

To deploy Rancher:

1. Create your terraform repo in your computer (if doesnt exists).
1. Install [Terraform](https://www.terraform.io/).
1. Create a [terraform module](https://developer.hashicorp.com/terraform/language/modules/syntax) inside your terraform repository
1. Point the source property in module to [Module's GitHub](https://github.com/GabSnow24/rancher-tf) using release tags (recommended), example:
    ```
    module "rancher" {
      source = "git::https://github.com/GabSnow24/rancher-tf//modules//rancher?ref=0.0.1"
      [...]
    }
    ```
1. Pass the parameters specified and necessary to run the module. Parameters are (all of them are mandatory):
    * cluster_name (String - The name of Rancher Cluster)
    * rancher_password (String - The password used in first sign in into Rancher, default password is 12345678)
    * key_name (String - The name of ssh key that will be used to access the host by ssh protocol, default name is "cluster_key")
    ```
    module "rancher" {
      source = "git::https://github.com/GabSnow24/rancher-tf//modules//rancher?ref=0.0.1"
      cluster_name = "rke"
      rancher_password = "12345678"
      key_name = "rke_key"
    }
    ```
1. Run `terraform init`.
1. Run `terraform plan`.
1. Run `terraform apply`.

## Access

After creation, in order to access Rancher UI, just copy the new instance public IP in AWS EC2 Dashboard, paste in browser and be happy c:


