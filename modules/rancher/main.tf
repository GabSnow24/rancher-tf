module "cluster_autoscaling" {
  source             = "git::https://github.com/GabSnow24/rancher-tf//modules//autoscaling?ref=${local.release_version}"
  template_data_name = "${var.cluster_name}-template"
  security_group = {
    id = module.security_groups.web_sg.id
  }
  subnets = {
    first  = module.network.public_subnet_1.id
    second = module.network.public_subnet_2.id
  }
  as_group_data = {
    name = "${var.cluster_name}-as-group"
  }
  rancher_password = var.rancher_password
  key_name         = var.key_name
}

module "security_groups" {
  source = "git::https://github.com/GabSnow24/rancher-tf//modules/sg?ref=${local.release_version}"
  vpc_data = {
    id = module.network.vpc_id
  }
}

module "network" {
  source = "git::https://github.com/GabSnow24/rancher-tf//modules//network?ref=${local.release_version}"
  vpc_data = {
    cidr_block = "172.31.0.0/16"
    name       = "VPC K8S"
  }

  public_subnet_1_data = {
    az         = "us-east-1a"
    cidr_block = "172.31.2.0/24"
  }

  public_subnet_2_data = {
    az         = "us-east-1b"
    cidr_block = "172.31.3.0/24"
  }
}