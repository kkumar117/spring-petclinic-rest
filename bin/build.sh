#!/usr/bin/env sh

set -eu

version=1.0.${CIRCLE_SHA1:-0}
checksum=${1:-none}
cd packer
PACKER_LOG=1 packer build -var "version=$version" -var "checksum=$checksum" template.json
