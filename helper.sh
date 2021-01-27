#!/bin/bash

clear -x

echo "Helper Script"
echo "============="
echo "1. Snapshot vagrant machines"
echo "2. Restore vagrant machines"
echo
echo -n "Enter selection: "
read option

case $option in
  1)
    for vm in $(vagrant status --machine-readable | grep metadata | sed 's/.*,\(.*\),metadata.*/\1/g')
    do
      vagrant snapshot save $vm base --force
    done
    ;;
  2)
    vagrant halt
    for vm in $(vagrant status --machine-readable | grep metadata | sed 's/.*,\(.*\),metadata.*/\1/g')
    do
      vagrant snapshot restore $vm base
    done
    ;;
  *)
    echo "Not a valid option"
    ;;
esac
