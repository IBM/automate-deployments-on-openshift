
#!/usr/bin/env sh

set -e

echo
echo "\033[1;32m---------------Setting up Argo CD----------------\033[0m"
cd CD/
./setup-GitOps.sh
cd ../
echo "\033[1;32m-------------Argo CD setup complete-------------\033[0m\n"
