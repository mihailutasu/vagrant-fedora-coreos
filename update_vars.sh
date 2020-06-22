#!/bin/bash

set -e

if ! command -v jq >/dev/null 2>&1; then
    echo "You need to install jq"
    exit 1
fi

printf "\nDownloading JSON files\n\n"

stable=$(curl 'https://builds.coreos.fedoraproject.org/streams/stable.json' | \
jq \
'.architectures.x86_64.artifacts.metal.release,
.architectures.x86_64.artifacts.metal.formats.iso.disk.location,
.architectures.x86_64.artifacts.metal.formats.iso.disk.sha256,
.architectures.x86_64.artifacts.metal.formats.iso.disk.signature,
.metadata."last-modified"
')

testing=$(curl 'https://builds.coreos.fedoraproject.org/streams/testing.json' | \
jq \
'.architectures.x86_64.artifacts.metal.release,
.architectures.x86_64.artifacts.metal.formats.iso.disk.location,
.architectures.x86_64.artifacts.metal.formats.iso.disk.sha256,
.architectures.x86_64.artifacts.metal.formats.iso.disk.signature,
.metadata."last-modified"
')

next=$(curl 'https://builds.coreos.fedoraproject.org/streams/next.json' | \
jq \
'.architectures.x86_64.artifacts.metal.release,
.architectures.x86_64.artifacts.metal.formats.iso.disk.location,
.architectures.x86_64.artifacts.metal.formats.iso.disk.sha256,
.architectures.x86_64.artifacts.metal.formats.iso.disk.signature,
.metadata."last-modified"
')


{ read stable_release; read stable_location; read stable_sha256; read stable_signature ; } <<< $stable
{ read testing_release; read testing_location; read testing_sha256; read testing_signature ; } <<< $testing
{ read next_release; read next_location; read next_sha256; read next_signature ; } <<< $next

#

printf "\nUpdating VARS files\n\n"
printf "STABLE:\n"
printf "{\"iso_url\": $stable_location,\"iso_checksum\": $stable_sha256,\"release\": $stable_release,\"os_name\": \"fedora-coreos-stable\"}" \
| jq . | tee var_stable.json
printf "TESTING:\n"
printf "{\"iso_url\": $testing_location,\"iso_checksum\": $testing_sha256,\"release\": $testing_release,\"os_name\": \"fedora-coreos-testing\"}" \
| jq . | tee var_testing.json
printf "NEXT:\n"
printf "{\"iso_url\": $next_location,\"iso_checksum\": $next_sha256,\"release\": $next_release,\"os_name\": \"fedora-coreos-next\"}" \
| jq . | tee var_next.json


