#!/bin/bash
TMC_CONTEXT=poc
TMC_CLUSTER=cluster-1 
tmc system context use $TMC_CONTEXT
tmc cluster provisionedcluster kubeconfig get-admin $TMC_CLUSTER > $KUBECONFIG
