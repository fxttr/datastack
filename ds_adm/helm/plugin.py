from ds_adm.runtime import helm


class HelmPlugin:
    def __init__(self, name: str, url: str):
        self.name = name
        self.url = url

    def __is_installed__(self):
        helm(f"plugin list | grep -qw {self.name}").returncode == 0

    def install(self, reinstall: bool = False):
        if not reinstall and self.__is_installed__():
            pass

        print(f"📦 Adding helm plugin {self.name}...")
        helm(f"plugin install {self.url}")
