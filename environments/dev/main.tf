terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.19.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
    
  }
}

provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/config")
  }
}

provider "kubectl" {
  config_path = pathexpand("~/.kube/config")
}

module "traefik" {
  source = "../../modules/traefik"
}

module "tailscale" {
  source = "../../modules/tailscale"
}

module "authelia" {
  source = "../../modules/authelia"
  authelia_username      = var.authelia_username
  authelia_password_hash = var.authelia_password_hash
  authelia_displayname   = var.authelia_displayname
  authelia_email         = var.authelia_email
  authelia_group         = var.authelia_group
}

module "cert_manager" {
  source = "../../modules/cert-manager"
}

module "postgres" {
  source = "../../modules/postgres"
}

module "mysql" {
  source = "../../modules/mysql"
}

module "grafana" {
  source = "../../modules/grafana"
}

module "glance" {
  source = "../../modules/glance"
}

module "plane" {
  source = "../../modules/plane"
}

module "kestra" {
  source = "../../modules/kestra"
}

module "erpnext" {
  source = "../../modules/erpnext"
}
