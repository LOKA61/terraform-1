variable "region" {
    type = string

}

variable "vpc_addr"{

    type = string
}

variable "subnet_punlic_ip"{

    type = string
}

variable subnet_private_ip {

    type = string
}
variable "rt_ip"{

    type = string
}

variable "tags" {
  type = map(string)
  default = {
    Name = "web-server"
    Environment = "dev"
  }
}