from ds_adm.runtime import kubectl


def apply():
    print("🔧 Adding config maps...")
    kubectl("apply -f k8s/manifests/")
