# builds the kustomize bundle that could be deployed to /etc/microshift/manifests
.PHONY: bundle
bundle:
	tar cvfz openshift-gitops-microshift.tar.gz openshift-gitops kustomization.yaml


.PHONY: help
help:
	@echo "bundle		-- Creates a tar.gz bundle with the required kustomize manifests for installing openshift-gitops in microshift"
