# Short Title

Automate cloud-native application lifecycle using OpenShift Pipeline and OpenShift GitOps Operators

# Long Title

Use OpenShift operators such as Pipelines (Tekton) and GitOps (Argo CD) to automate build, Deploy and Manage aspects of your cloud-native application.

# Author

* [Manoj Jahgirdar](https://developer.ibm.com/profiles/manoj.jahgirdar)
* [Rahul Reddy Ravipally](https://developer.ibm.com/profiles/raravi86)
* [Srikanth Manne](https://developer.ibm.com/profiles/srikanth.manne)

# URLs

### Github repo

* https://github.com/IBM/automated-openshift-deployments

# Summary

In this code pattern, you will learn how to create a continuous integration (CI) and a continuous delivery (CD) mechanism for your cloud-native applications using Red Hat OpenShift Pipeline and Red Hat OpenShift GitOps Operators. You will learn how to use Red Hat OpenShift Pipeline to create a pipeline that will build and test your application, build container image for your application and push it to container registry and update the configuration files in the GitOps repository. You will also learn how these configuration files are taken from the GitOps repository and resources are created accordingly on the OpenShift cluster using Red Hat OpenShift GitOps.

>Red Hat OpenShift Pipelines is a cloud-native continuous integration and delivery (CI/CD) solution for building pipelines using Tekton.

>Red Hat OpenShift GitOps is a declarative continuous delivery platform based on Argo CD.

# Description

In the era of cloud computing, the need for cloud-native appilcations is on the rise. Continuous Integration (CI) and Continuous Delivery (CD) are essential in the cloud-native application lifecycle. The CI/CD pipeline basically automates your software delivery process. It allows you to distribute software quickly and efficiently. It also allows an effective process for getting products to market rapidly, continuously delivering code into production, and ensuring an ongoing flow of new features and bug fixes through an efficient delivery method such as GitOps. GitOps automates infrastructure updates using a Git workflow. When new code is merged, the CI/CD pipeline reflects the change in the environment.

This code pattern teaches you the continuous integration (CI) and continuous delivery (CD) mechanism for your cloud-native applications using Red Hat OpenShift Pipeline and Red Hat OpenShift GitOps Operators.

Once you complete the code pattern, you will learn to:

* Use Tekton to build CI pipelines on OpenShift
* Create a Continuous Integration (CI) mechanism for your cloud-native applications using OpenShift Pipeline
* Use Argo CD as an declarative continuous delivery platform on OpenShift
* Create a Continuous Delivery (CD) mechanism for your cloud-native applications using OpenShift GitOps
* Setup an automation to build and deploy your cloud-native applications on a code change in your GitHub Repository

# Flow

![architecture](doc/source/images/architecture.png)

1. User checks in the code to the source control repository
2. GitHub webhook triggers an OpenShift Pipeline on the push event
3. First Tekton CI task runs to clone the code from the GitHub repository
4. Second Tekton CI task runs to build the container image from the source code. The image is then pushed to the container registry
5. Third Tekton CI task runs to update the deployment configuration with the new image and store the configuration files in the GitOps repository
6. The OpenShift GitOps picks up the configuration files from the GitOps repository and deploys to the OpenShift cluster

# Instructions

> Find the detailed steps in the [README](https://github.com/IBM/automated-openshift-deployments/blob/master/README.md) file.

1. Setup Repositories
    * 1.1. Setup source code repository
    * 1.2. Setup GitOps repository
    * 1.3. Setup container registry
2. Setup OpenShift Pipeline Operator
    * 2.1. Deploy OpenShift Pipeline on the cluster
    * 2.2. Create Tekton Tasks, Pipeline and Secrets
    * 2.3. View the Tekton Pipeline
3. Setup OpenShift GitOps Operator
    * 3.1. Deploy OpenShift GitOps on the cluster
    * 3.2. Create ArgoCD Application
    * 3.3. View the ArgoCD Dashboard
4. View the Temperature converter Application
5. Setup Trigger and Event Listener
    * 5.1. Create a Tekton Trigger for the Tekton Pipeline
    * 5.2. Add webhook to the source code repository
6. Analyze the worlflow

# Components and services

* Red Hat OpenShift Pipelines
* Red Hat OpenShift GitOps