

provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/config")
  }
}

provider "kubectl" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_ca)
  token                  = data.aws_eks_cluster_auth.main.token
  load_config_file       = false

  config_path = pathexpand("~/.kube/config")
}

module "traefik" {
  source = "../../modules/traefik"
}

module "tailscale" {
  source = "../../modules/tailscale"
}

/*
module "authelia" {
  source = "../../modules/authelia"
  authelia_username      = var.authelia_username
  authelia_password_hash = var.authelia_password_hash
  authelia_displayname   = var.authelia_displayname
  authelia_email         = var.authelia_email
  authelia_group         = var.authelia_group
}
*/
/*
module "cert_manager" {
  source = "../../modules/cert-manager"
}
*/
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
