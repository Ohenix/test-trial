# defininig varibales 

variable "aws_region" {
  default     = "eu-west-2"
  description = "vpc region"
}

variable "enable-dns-hostnames" {
  default     = "true"
  description = "dns hostname"
}


variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable public_subnet_cidr_1 {
  default     = "10.0.1.0/24"
  description = "public subnet 1 cidr"
}

variable public_subnet_cidr_2 {
  default     = "10.0.2.0/24"
  description = "public subnet 2 cidr"
}

variable public_subnet_cidr_3 {
  default     = "10.0.3.0/24"
  description = "public subnet 3 cidr"
}


variable private_subnet_cidr_1 {
  default     = "10.0.4.0/24"
  description = "private subnet 1 cidr"
}

variable private_subnet_cidr_2 {
  default     = "10.0.5.0/24"
  description = "private subnet 2 cidr"
}

variable private_subnet_cidr_3 {
  default     = "10.0.6.0/24"
  description = "private subnet 3 cidr"
} 