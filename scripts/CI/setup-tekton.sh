#!/usr/bin/env sh

set -e

cd Tekton/

echo 
echo "\033[1;34mSetting up Tekton Tasks...\033[0m"
cd Tasks/
oc apply -f app-setup.yaml
oc apply -f app-nodejs-build.yaml
oc apply -f container-image-builder.yaml
oc apply -f config-updater.yaml
cd ../
echo "\033[1;34mTekton Tasks setup complete.\033[0m\n"

echo "\033[1;34mSetting up Tekton Pipeline...\033[0m"
cd Pipeline/
oc apply -f pipeline.yaml
cd ../
echo "\033[1;34mTekton Pipeline setup complete.\033[0m\n"

echo "\033[1;34mSetting up Tekton Secrets...\033[0m"
cd Secrets/
echo "\033[1;36mEnter your Git username:\033[0m"
read GITUSERNAME
echo "\033[1;36mEnter your Git personal access token:\033[0m"
read GITPERSONALACCESSTOKEN
oc apply -f github-secrets.yaml
oc patch secret git-credentials -p '{"stringData": {"username": "'$GITUSERNAME'", "password": "'$GITPERSONALACCESSTOKEN'"}}'
echo "\033[1;34mGit credentials configured. You can view them by running:\033[0m"
echo "\033[1;35moc get secret git-credentials -o yaml\033[0m\n"

echo "\033[1;36mEnter your DockerHub username:\033[0m"
read DOCKERUSERNAME
echo "\033[1;36mEnter your DockerHub personal access token:\033[0m"
read DOCKERPERSONALACCESSTOKEN
oc apply -f container-registry-secrets.yaml
oc patch secret docker-credentials -p '{"stringData": {"username": "'$DOCKERUSERNAME'", "password": "'$DOCKERPERSONALACCESSTOKEN'"}}'
echo "\033[1;34mDocker credentials configured. You can view them by running:\033[0m"
echo "\033[1;35moc get secret docker-credentials -o yaml\033[0m\n"
cd ../
echo "\033[1;34mTekton Secrets setup complete.\033[0m\n"

echo "\033[1;34mPatching Pipeline ServiceAccount...\033[0m"
oc patch sa pipeline -p '{"secrets": [{"name": "git-credentials"}]}'
oc patch sa pipeline -p '{"secrets": [{"name": "docker-credentials"}]}'
oc patch sa pipeline -p '{"imagePullSecrets": [{"name": "docker-credentials"}]}'
echo "\033[1;34mPipeline ServiceAccount setup complete.\033[0m\n"

cd ../

echo "\033[1;32mTekton CI pipeline setup complete. Do you want to trigger the pipeline now? (y/n)\033[0m"
read -r answer
if [ "$answer" != "${answer#[Yy]}" ] ;then

    tkn pipeline start gitops-build-pipeline \
    -w name=doc-source,emptyDir="" \
    -p git-url=$GIT_URL \
    -p git-rev=$GIT_BRANCH \
    -p image-name=$CONTAINER_IMAGE_NAME \
    -p image-tag=$CONTAINER_IMAGE_TAG \
    -p gitops-url=$GITOPS_URL \
    --use-param-defaults
else
    echo "\033[1;34mYou can run the pipeline later with the following command:\033[0m"
    echo "\033[1;35mtkn pipeline start gitops-build-pipeline \
    -w name=doc-source,emptyDir=\"\" \
    -p git-url=$GIT_URL \
    -p git-rev=$GIT_BRANCH \
    -p image-name=$CONTAINER_IMAGE_NAME \
    -p image-tag=$CONTAINER_IMAGE_TAG \
    -p gitops-url=$GITOPS_URL \
    --use-param-defaults\033[0m"

fi
