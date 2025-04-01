resource "helm_release" "authelia" {
  name             = "authelia"
  repository       = "https://charts.authelia.com"
  chart            = "authelia"
  namespace        = "authelia"
  version          = "0.8.45"
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml", {
      username      = sensitive(var.authelia_username)
      password_hash = sensitive(var.authelia_password_hash)
      displayname   = sensitive(var.authelia_displayname)
      email         = sensitive(var.authelia_email)
      group         = sensitive(var.authelia_group)
    })
  ]
}

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