#!/bin/bash

wget -c https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

qemu-img convert -f qcow2 -O raw jammy-server-cloudimg-amd64.img jammy-server-cloudimg-raw-amd64.img

# Remove the original QCOW2 file to keep the Docker context small
rm jammy-server-cloudimg-amd64.img

docker build -t harshitg/ubuntu-server-22.04:raw .

rm jammy-server-cloudimg-raw-amd64.img
