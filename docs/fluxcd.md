# FluxCD GitOps

FluxCD v2 is a GitOps workflow which allows deploying kubernetes resources. 
This repository use Kustomization with FluxCD to allow customization for different
environments.

FluxCD managed resources are available in [flux](../flux) folder. Folder has following
structure. In a given Kubernetes cluster flux operator is pointed to one of the environments
(ex: dev) and flux provision kubernetes resources accordingly. Kustomization manifest
defines the infrastructure and app resources by referencing infrastructure and app folders.

```shell
flux
|- apps
|- clusters
   |- dev
|- infrastructure
```

## Bootstrap Flux

Flux is not automatically bootstrapped in the kuberenetes cluster. This is manual process. Once
the kubernetes cluster up and running follow the steps below to bootstrap the flux.

### Pre-requisites

FluxCD bootstrap itself as GitOps and make changes to the Github repository. In order to access 
the Github repository by FluxCD, personal access token need to be created.

* Github Personal Access Token - Log-in to the Github account and navigate to user settings -> 
  developer setting. Under personal access tokens section create a token and copy the token value
* By default, FluxCD bootstrap script will make changes to the master branch. This can be override by 
exporting GITHUB_BRANCH parameter.

### Bootstrap
```shell
# Commands will be run inside the master VM as vagrant user
vagrant ssh master

# Export github values
export GITHUB_TOKEN=<personal access token>
export GITHUB_USER=<github username>
export GITHUB_REPO=kubernetes-playground

# If FluxCD must poll different branch export the branch name
export GITHUB_BRANCH=dev

# Run bootstrap script
/vagrant/scripts/install-flux2
```

### Verification

```shell
# These commands run inside the VM master
vagrant ssh master

# List all the helm releases. They may show up still reconcilation and eventually successful
flux get helmreleases -A
```