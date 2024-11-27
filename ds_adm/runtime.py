import subprocess

from ds_adm import PROVIDER


def run_command(command, check=True, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL):
    """Run a shell command."""
    try:
        return subprocess.run(command, shell=shell, check=check, stdout=stdout, stderr=stderr)
    except subprocess.CalledProcessError as e:
        print(f"Error while executing: {command}")
        raise e

def kubectl(command, check=True, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL):
    return run_command(f"${PROVIDER} kubectl {command}", check=check, shell=shell, stdout=stdout, stderr=stderr)

def helm(command, check=True, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL):
    return run_command(f"${PROVIDER} helm {command}", check=check, shell=shell, stdout=stdout, stderr=stderr)
