#! /bin/bash

for pod in `kubectl get po --namespace f5gc -l exp=exp-01-ue -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
    echo "Pod: $pod"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun0 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun1 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun2 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun3 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun4 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun5 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun6 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun7 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun8 1.1.1.1&"
    kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "ping -I uesimtun9 1.1.1.1&"
done

