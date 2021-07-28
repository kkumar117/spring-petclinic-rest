#!/usr/bin/env sh

set -eu

# Use `ls | sort` to make checksum to be deterministic since it will be used to choosing the AMI
cat $(find packer packer/provision.sh packer/template.json terraform/user_data/config.sh.tpl -type f | sort) | md5sum | cut -d ' ' -f 1
