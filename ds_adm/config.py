from ds_adm import PROVIDER
from ds_adm.helm.chart import HelmChart
from ds_adm.helm.plugin import HelmPlugin
from ds_adm.helm.repository import HelmRepository
from ds_adm.kube.operator import KubeOperator
import yaml

class Config(yaml.YAMLObject):
    yaml_loader = yaml.SafeLoader
    yaml_tag = u'!dsadm'

    def __init__(self,
                 repos: list[HelmRepository] = [], 
                 plugins: list[HelmPlugin] = [],
                 charts: list[HelmChart] = [],
                 operators: list[KubeOperator] = []):
        self.provider = PROVIDER
        self.repos = repos
        self.plugins = plugins
        self.charts = charts
        self.operators = operators

def parse(path: str = "ds_config.yaml") -> Config:
    with open(path, 'r') as file:
        return yaml.safe_load(file)
    

