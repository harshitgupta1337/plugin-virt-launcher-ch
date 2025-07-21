#!/bin/bash

print_usage() {
    echo "This is a script to build and push the Libvirt-QEMU based virt-launcher image."
    echo ""
    echo "Script usage: ./build-virt-launcher-image.sh -P <DOCKER_PREFIX> -T <DOCKER_TAG> [-K (dont delete builder ctr)]"
    echo "For example: ./build-virt-launcher-image.sh -P acrafoimages.azurecr.io/kubevirt-mshv/ -T 20241112-1"
    echo ""
    echo "For usage, run ./build-virt-launcher-image.sh -H"
}

DELETE_BUILDER=true

while getopts ":H:KP:T:" option; do
    case $option in
    H) # display Help
        print_usage
        exit
        ;;
    P) # DOCKER_PREFIX
        DOCKER_PREFIX=$OPTARG ;;
    T) # DOCKER_TAG
        DOCKER_TAG=$OPTARG ;;
    K) # KEEP_BUILDER
        DELETE_BUILDER=false ;;
    \?) # Invalid option
        echo "Error: Invalid option"
        exit
        ;;
    esac
done

if [ -z "$DOCKER_PREFIX" ] || [ -z "$DOCKER_TAG" ]; then
    echo "Error: This script requires DOCKER_PREFIX and DOCKER_TAG args to be provided."
    print_usage
    exit 1
fi

BUILDER_IMG=quay.io/kubevirt/builder:2505091401-8ab710cdb8

# Mount Docker config to the Builder container for pushing built images to registry
volumes="--mount type=bind,source=${HOME}/.docker/config.json,target=/root/.docker/config.json,readonly"

# Download KubeVirt's MSFT fork - branch containing refactored virt-launcher code
git clone --depth 1 -b virtstack-crd-rebased https://github.com/harshitgupta1337/kubevirt.git
KUBEVIRT_CORE_PATH=$(realpath ./kubevirt)

# Delete cloud-hypervisor virt-launcher code from KubeVirt Core
pushd $KUBEVIRT_CORE_PATH
rm -rf cmd/virt-launcher* pkg/virt-launcher-cloud-hypervisor
popd

# Mount the KubeVirt core repository to the builder (as readonly)
volumes="$volumes --mount type=bind,source=${KUBEVIRT_CORE_PATH},target=/kubevirt,readonly"

LAUNCHER_PATH=$(pwd)
# Mount the Libvirt-QEMU virt-launcher repo directory to the builder
volumes="$volumes --mount type=bind,source=${LAUNCHER_PATH},target=/virt-launcher-cloud-hypervisor"

# Launch the builder container
ctr=$(docker run -d --ulimit nofile=10000:10000 --network host $volumes --security-opt "label=disable" $BUILDER_IMG /bin/sleep infinity)

docker exec -it $ctr bash -c "cd virt-launcher-cloud-hypervisor && export DOCKER_PREFIX=${DOCKER_PREFIX} && export DOCKER_TAG=${DOCKER_TAG} && ./hack/bazel-build-images.sh && ./hack/bazel-push-images.sh"

if [ "$DELETE_BUILDER" == "true" ]; then
    docker rm -f $ctr
    rm -rf $KUBEVIRT_CORE_PATH
fi
