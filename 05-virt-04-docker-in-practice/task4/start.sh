#!/bin/bash
git clone https://github.com/ServerOwl/shvirtd-example-python.git /opt/shvirtd-example-python/
docker compose -f /opt/shvirtd-example-python/compose.yaml up
