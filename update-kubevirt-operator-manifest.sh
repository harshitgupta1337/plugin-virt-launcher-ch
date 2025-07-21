#!/bin/bash

print_usage() {
    echo "This is a script to update KubeVirt Operator manifest with custom virt-launcher image."
    echo ""
    echo "Script usage: ./update-kubevirt-operator-manifest.sh \\"
    echo "                  -I <Input KV Operator Manifest YAML>"
    echo "                  [-O <Output KV Operator Manifest YAML (optional, written to stdout if not provided)>]"
    echo "                  -L <URI of virt-launcher image>"
    echo ""
    echo "For usage, run ./update-kubevirt-operator-manifest.sh -H"
}

while getopts ":HI:O:L:" option; do
    case $option in
    H) # display Help
        print_usage
        exit
        ;;
    I)
        IN_MANIFEST=$OPTARG ;;
    O)
        OUT_MANIFEST=$OPTARG ;;
    L)
        LAUNCHER_IMG=$OPTARG ;;
    \?) # Invalid option
        echo "Error: Invalid option"
        exit
        ;;
    esac
done

if [ -z "$IN_MANIFEST" ] || [ -z "$LAUNCHER_IMG" ]; then
    echo "Error: Insufficient arguments provided to script. Exiting..."
    print_usage
    exit 1
fi

if [ -z "$OUT_MANIFEST" ]; then
  OUT_MANIFEST=/dev/stdout
fi

yq ea "
  select(.kind == \"Deployment\") |= (
    .spec.template.spec.containers[0].env = (.spec.template.spec.containers[0].env | map(select(.name != \"VIRT_LAUNCHER_IMAGE\" and .name != \"VIRT_LAUNCHER_SHASUM\" ))) |
    .spec.template.spec.containers[0].env += {\"name\": \"VIRT_LAUNCHER_IMAGE\", \"value\": \"$LAUNCHER_IMG\"}
  )
  // select(.)
" $IN_MANIFEST >$OUT_MANIFEST
