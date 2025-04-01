variable "authelia_username" {
  description = "Authelia username"
  type        = string
  sensitive   = true
}

variable "authelia_password_hash" {
  description = "Authelia password hash"
  type        = string
  sensitive   = true
}

variable "authelia_displayname" {
  description = "Authelia display name"
  type        = string
  sensitive   = true
}

variable "authelia_email" {
  description = "Authelia email"
  type        = string
  sensitive   = true
}

variable "authelia_group" {
  description = "Authelia group"
  type        = string
  sensitive   = true
}