#!/usr/bin/env sh

set -e

echo
echo "\033[1;32m-------------Setting up Tekton CI----------------\033[0m"
cd CI/
chmod +x setup-tekton.sh
./setup-tekton.sh
cd ../
echo "\033[1;32m-----------Tekton CI setup complete-------------\033[0m\n"