terraform {
  required_version = ">= 0.13"

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
  apply_retry_count      = 15
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_ca)
  load_config_file       = false

  config_path = pathexpand("~/.kube/config")

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws-iam-authenticator"
    args = [
      "token",
      "-i",
      module.eks.cluster_id,
    ]
  }
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
