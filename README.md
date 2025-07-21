## Overview

This repository contains code for a Libvirt-QEMU-specific virt-launcher component of KubeVirt.

## Building Instructions

The following command will build and publish the `virt-launcher` container image.

```bash
./build-virt-launcher-image.sh -P <DOCKER_PREFIX> -T <DOCKER_TAG>
```

For building the `virt-launcher` component independent from the core KubeVirt project,
this repository relies on the `virtstack-plugin-refactor` branch of the [`microsoft/kubevirt`](https://github.com/microsoft/kubevirt/tree/virtstack-plugin-refactor) fork of KubeVirt. This specific branch has the common parts of `virt-launcher` isolated, which are needed to build the Libvirt-QEMU-specific `virt-launcher`.

## Installing on a KubeVirt cluster

The following command will update an existing KubeVirt Operator manifest and ensure that the specified `virt-launcher` image is used.

```bash
./update-kubevirt-operator-manifest.sh \
    -I <Input KV Operator Manifest YAML> \
    -L <URI of virt-launcher image> \
    [-O <Output KV Operator Manifest YAML (optional, written to stdout if not provided)>]
```
