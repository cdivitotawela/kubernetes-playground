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
    vagrant snapshot save master base --force
    vagrant snapshot save node1 base --force
    vagrant snapshot save node2 base --force
    ;;
  1)
    vagrant halt
    vagrant snapshot restore master base
    vagrant snapshot restore node1 base
    vagrant snapshot restore node2 base
    ;;
  *)
    echo "Not a valid option"
    ;;
esac
