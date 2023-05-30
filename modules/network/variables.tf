variable "vpc_data" {
   type = object({
    cidr_block = string
    name = string
  })
}

variable "public_subnet_1_data" {
 type = object({
    az = string
    cidr_block = string
  })
}

variable "public_subnet_2_data" {
 type = object({
    az = string
    cidr_block = string
  })
}