from ds_adm.runtime import kubectl


def apply():
    """Initialize the Kubernetes namespaces."""
    print("🌟 Initialize Kubernetes Namespaces...")
    kubectl("apply -f k8s/namespaces/")

