module "traefik" {
  source = "../../modules/traefik"
}

module "tailscale" {
  source = "../../modules/tailscale"
}

module "authelia" {
  source = "../../modules/authelia"
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

provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/config")
  }
}
