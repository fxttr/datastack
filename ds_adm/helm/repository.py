from ds_adm.runtime import helm


class HelmRepository:
    def __init__(self, name: str, url: str):
        self.name = name
        self.url = url
    
    def __is_installed__(self):
        helm(f"repo list | grep -qw {self.name}").returncode == 0

    def install(self, reinstall: bool = False):
        if not reinstall and self.__is_installed__():
            pass

        print(f"📦 Adding helm repository {self.name}...")
        helm(f"repo add {self.name} {self.url}")
        helm(f"repo update")

