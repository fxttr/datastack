#!/usr/bin/env python3

import argparse
import ds_adm.config as config

def run_all(config: config.Config):
    for plugin in config.plugins:
        plugin.install()

    for repo in config.repos:
        repo.install()

    for chart in config.charts:
        chart.install()

    for operator in config.operators:
        pass

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
                    prog='dsadm',
                    description='Managing the datastack')
    
    parser.add_argument('-a', '--all', action='store_true')
    args = parser.parse_args()
    ds_config = config.parse()
    
    if args.all:
        run_all(ds_config)
    