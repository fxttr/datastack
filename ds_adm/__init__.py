from pathlib import Path


def __resolve_provider__() -> str:
    """Determine the current provider"""
    def __is_valid_command__(name):
        """Check whether `name` is on PATH and marked as executable."""

        from shutil import which

        return which(name) is not None

    if __is_valid_command__("talosctl"):
        return "talosctl"
        
    if __is_valid_command__("microk8s"):
        return "microk8s"
    
    raise Exception("Could not find any provider!")

def __is_first_run__() -> bool:
    lock_file = Path(__file__).joinpath("/../.dsadm_lockfile")
    result = False

    if not lock_file.exists():
        result = True
        lock_file.touch()

    return result

PROVIDER = __resolve_provider__()
#IS_FIRST_RUN = __is_first_run__()