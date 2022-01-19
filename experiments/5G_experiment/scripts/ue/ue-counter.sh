#! /bin/bash
# Count UEs up and connected.

UE_NUM=0

for pod in `kubectl get po --namespace f5gc -l exp=exp-03-ue -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
    echo "Pod: $pod"
    POD_NUM=$(kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "ip a | grep uesimtun | wc -l")
    echo $(($POD_NUM/2))
    UE_NUM=$(($UE_NUM+$POD_NUM/2))
done
echo $UE_NUM
