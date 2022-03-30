#!/usr/bin/env sh

set -e

echo
echo "\033[1;31m---------------------Deleting Tekton CI---------------------\033[0m"
cd CI/
chmod +x delete-tekton.sh
./delete-tekton.sh
cd ../
echo "\033[1;31m---------------Tekton CI deleted successfully---------------\033[0m\n"
