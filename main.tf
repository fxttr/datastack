module "k8s" {
  source = "./k8s"
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.25.2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }

    sops = {
      source = "carlpett/sops"
      version = ">=1.1.1"
    }
  }
}

provider "kubernetes" {
 config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "sops" {}