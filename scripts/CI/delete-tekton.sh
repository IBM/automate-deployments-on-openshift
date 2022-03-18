#!/usr/bin/env sh

set -e

cd Tekton/

echo 
echo "\033[1;34mDeleting Tekton Tasks...\033[0m"
cd Tasks/
oc delete -f app-setup.yaml
oc delete -f app-nodejs-build.yaml
oc delete -f container-image-builder.yaml
oc delete -f config-updater.yaml
cd ../
echo "\033[1;34mTekton Tasks deleted successfully.\033[0m\n"

echo "\033[1;34mDeleting Tekton Pipeline...\033[0m"
cd Pipeline/
oc delete -f pipeline.yaml
cd ../
echo "\033[1;34mTekton Pipeline deleted successfully.\033[0m\n"

echo "\033[1;34mDeleting Tekton Secrets...\033[0m"
cd Secrets/
oc delete -f github-secrets.yaml
oc delete -f container-registry-secrets.yaml
cd ../
echo "\033[1;34mTekton Secrets deleted successfully.\033[0m\n"

cd ../
echo "\033[1;32mSuccessfully deleted Tekton CI pipeline.\033[0m\n"