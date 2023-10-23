# openshift-gitops-microshift
This repo contains kustomize manifests and the documented steps that can help installing upstream ArgoCD core profile on a microshift instance.
Only the following core components would be installed in the microshift instance.
- application-controller
- repo-server
- redis

## Testing on a openshift-local(CRC) cluster on your laptop

### Setup CRC with microshift preset
- Install the openshift-local(CRC) binary from this location https://developers.redhat.com/products/openshift-local/overview
- Initialize the CRC cluster
```crc setup```
- Set the preset to microshift
```crc config set preset microshift```
- Start the CRC instance and wait till the required processes comes up
```crc start```
- Check the status of the cluster and ensure that the instance is in `Running` state and is healthy.
```crc status```

### Connect to the local CRC instance

```ssh -i ~/.crc/machines/crc/id_ecdsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 core@127.0.0.1```

### Transfer the bundle to the CRC cluster

``` scp -i ~/.crc/machines/crc/id_ecdsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -P 2222 openshift-gitops-microshift.tar.gz core@127.0.0.1:/home/core ```
### Extract the bundle and restart microshift service

```
sudo tar zxvf /home/core/openshift-gitops-microshift.tar.gz -C /etc/microshift/manifests/

sudo systemctl restart microshift
```

### Running ArgoCD CLI commands

- List deployed apps
```argocd --core app list```
- Create a new app
```argocd --core app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-namespace default --dest-server https://kubernetes.default.svc --directory-recurse```
- Sync a new app
```argocd app sync --core guestbook```
