#!/usr/bin/env sh

set -e

echo
echo "\033[1;31m-------------------Deleting ArgoCD apps---------------------\033[0m"
cd CD/
./delete-GitOps.sh
cd ../
echo "\033[1;31m-------------ArgoCD apps deleted successfully---------------\033[0m\n"