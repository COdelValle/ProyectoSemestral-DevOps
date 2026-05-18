variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "innovatech"
}

variable "key_pair_name" {
  description = "Nombre de la clave SSH para la EC2"
}

variable "db_password" {
  description = "Contraseña de producción para MySQL"
  type        = string
  sensitive   = true
}