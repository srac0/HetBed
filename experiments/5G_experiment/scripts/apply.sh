#! /bin/bash

# MULTI_AMF=true
# MULTI_SMF=true
MULTI_AMF=false
MULTI_SMF=false

kubectl create -f ./manifests/00_namespace.yaml
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-mongodb/
read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-nrf/
read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-udr/
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-udm/
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-ausf/
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-nssf/
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-amf/
if $MULTI_AMF; then
    kubectl apply -k ./manifests/f5gc-amf-2/
fi
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-pcf/
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-upf/
if $MULTI_SMF; then
    kubectl apply -k ./manifests/f5gc-upf-2/
fi
read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-smf/
if $MULTI_SMF; then
    kubectl apply -k ./manifests/f5gc-smf-2/
    ./scripts/ue-slice-selector.sh
fi
# read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/f5gc-webui/
# read -n 1 -s -r -p "Press any key to continue"
kubectl cp ./scripts/mongo-dump/mongo-dump-1000-ue f5gc-mongodb-0:/tmp/mongo-dump -n f5gc
kubectl exec f5gc-mongodb-0 -n f5gc -- /bin/sh -c "mongorestore --gzip --archive=/tmp/mongo-dump"
read -n 1 -s -r -p "Press any key to continue"
kubectl apply -k ./manifests/ueransim-gnb/
# read -n 1 -s -r -p "Press any key to continue"
if $MULTI_AMF; then
    kubectl apply -k ./manifests/overlays/multi-amf/ueransim-gnb-2/
else
    kubectl apply -k ./manifests/ueransim-gnb-2/
fi
# read -n 1 -s -r -p "Press any key to continue"
# kubectl apply -k ./manifests/ueransim-gnb-3/
# read -n 1 -s -r -p "Press any key to continue"
# kubectl apply -k ./manifests/ueransim-gnb-4/
# read -n 1 -s -r -p "Press any key to continue"
# kubectl apply -k ./manifests/ueransim-gnb-5/
# read -n 1 -s -r -p "Press any key to continue"
# kubectl apply -k ./manifests/ueransim-gnb-6/
./scripts/network_control.sh
