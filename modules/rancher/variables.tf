variable "cluster_name" {
  type    = string
  default = "rke-master"
}

variable "rancher_password" {
  type    = string
  default = "12345678"
}

variable "key_name" {
  type    = string
  default = "cluster_key"
}