from ds_adm.runtime import helm


class HelmChart:
    def __init__(self, name: str, namespace: str, repo: str, values: str):
        self.name = name
        self.namespace = namespace
        self.repo = repo
        self.values = values

    def install(self):
        print(f"🚀 Installing helm chart {self.name} in the {self.namespace} namespace...")
        helm(f"upgrade --install {self.name} {self.repo} --namespace {self.namespace} -f k8s/values/{self.values}")

