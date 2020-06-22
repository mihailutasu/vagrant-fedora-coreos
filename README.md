# vagrant-fedora-coreos

A project for building [Fedora CoreOS](https://getfedora.org/en/coreos?stream=stable) boxes for Vagrant.

## Requirements

- [Packer](https://www.packer.io/)
- [VirtualBox](https://www.virtualbox.org)
- [Podman](https://podman.io/) or [Docker](https://www.docker.com/) (or FCCT installed) - to generate your own Ignition files
- [jq](https://stedolan.github.io/jq/) - if you want to download the latest images of CoreOS

## Usage

To build a box, you need to run packer. Eg.:

`
$ packer build -var-file var_stable.json fedora-coreos.json
`

This will download the ISO image (if not already in packer's cache) and will build the box.

You might also want to update var_*.json files first, to the latest versions:

`
$ sh update_vars.sh
`

In *utils/config.ign.yml* you'll find a basic machine config file.

## License

```text
Copyright 2020, Mihai Lutasu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
