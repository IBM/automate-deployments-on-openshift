#!/usr/bin/env sh

set -e

cd GitOps/

echo
echo "\033[1;34mSetting up GitOps Repository '$GITOPS_URL'\033[0m"

NAMESPACE=$(oc config view --minify -o jsonpath='{..namespace}')
echo "\033[1;37mKubernetes/OpenShift Namespace: $NAMESPACE\033[0m\n"

echo
echo "\033[1;33mLogging in to ArgoCD\033[0m"
argocd login $ARGOSERVER --insecure --username admin --password $ARGOPASSWORD

echo
echo "\033[1;34mSetting up the ArgoCD application\033[0m"
cd ArgoCD/
python -c 'import yaml;f=open("application.yaml");y=yaml.safe_load(f);y["spec"]["destination"]["namespace"] = "'${NAMESPACE}'";f.close();f=open("application.yaml","w");yaml.dump(y,f);f.close()'
python -c 'import yaml;f=open("application.yaml");y=yaml.safe_load(f);y["spec"]["source"]["repoURL"] = "'${GITOPS_URL}'";f.close();f=open("application.yaml","w");yaml.dump(y,f);f.close()'
argocd app create -f application.yaml
cd ../
echo "\033[1;34mArgo CD application setup completed\033[0m\n"

cd ../

echo "\033[1;32mSuccessfully completed setting up GitOps Repository. Do you want to sync the Argo CD application? (y/n)\033[0m"
read -r answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Syncing the ArgoCD application..."
    argocd app sync temperature-converter-app
else
    echo "\033[1;34mYou can sync the Argo CD application later with the following command:\033[0m"
    echo "\033[1;35margocd app sync temperature-converter-app\033[0m"
fi
