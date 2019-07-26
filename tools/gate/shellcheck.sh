#!/bin/bash

set -xe

sudo apt-get update
sudo apt-get install --no-install-recommends -y shellcheck

shellcheck -e SC2029 --shell=bash *.sh etc/*.sh tools/*.sh
