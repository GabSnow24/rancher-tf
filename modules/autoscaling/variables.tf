variable "template_data_name" {
   type = string
}

variable "security_group" {
  type = object({
      id = string
    })
}
variable "subnets" {
  type = object({
    first = string
    second = string
  })
}


variable "as_group_data" {
  type = object({
      name = string
    })
}

variable "rancher_password" {
  type = string 
  default = "12345678"
}

variable "key_name" {
  type = string 
  default = "cluster_key"
}