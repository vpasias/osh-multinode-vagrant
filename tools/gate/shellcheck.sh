#!/bin/bash

set -xe

sudo apt-get update
sudo apt-get install --no-install-recommends -y shellcheck

shellcheck *.sh --shell=bash
shellcheck etc/*.sh --shell=bash
shellcheck tools/*.sh --shell=bash
