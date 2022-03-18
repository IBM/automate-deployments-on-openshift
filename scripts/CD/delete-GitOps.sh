#!/usr/bin/env sh

set -e

cd GitOps/

echo
echo "\033[1;34mDeleting GitOps Repository '$GITOPS_URL'\033[0m"

NAMESPACE=$(oc config view --minify -o jsonpath='{..namespace}')
echo "\033[1;37mKubernetes/OpenShift Namespace: $NAMESPACE\033[0m\n"

echo "\033[1;34mRemoving RBAC roles for the namespace '$NAMESPACE'\033[0m"
cd RBAC/
oc delete -f rbac.yaml -n $NAMESPACE
cd ../
echo "\033[1;34mRBAC roles removed\033[0m\n"

echo "\033[1;33mLogging in to ArgoCD\033[0m"
argocd login $ARGOSERVER --insecure --username admin --password $ARGOPASSWORD

echo
echo "\033[1;34mRemoving the ArgoCD application\033[0m"
cd ArgoCD/
argocd app delete temperature-converter-app
cd ../
echo "\033[1;34mArgoCD application removed\033[0m\n"

cd ../

echo
echo "\033[1;32mSuccessfully Deleted GitOps CD\033[0m\n"