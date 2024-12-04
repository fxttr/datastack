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

    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.2"
    }
  }
}

provider "kubernetes" {
 config_path = "~/.kube/config"
}
