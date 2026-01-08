variable "network_name" {
  description = "Docker network name"
  type        = string
  default     = "app_network"
}

variable "db_image" {
  description = "Postgres image"
  type        = string
  default     = "postgres:15"
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "web_port" {
  description = "Web server exposed port"
  type        = number
  default     = 8080
}
