class KubeOperator:
    def __init__(self, name: str, namespace: str, definition: str, deployments: list[str]):
        self.name = name
        self.namespace = namespace
        self.defioniton = definition
        self.deployments = deployments

    