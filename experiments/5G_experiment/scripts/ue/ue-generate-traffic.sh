#! /bin/bash

for pod in `kubectl get po --namespace f5gc -l exp=exp-01-ue -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
    echo "Pod: $pod"
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5201 --bidir -B 60.60.0.1  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5202 --bidir -B 60.60.0.2  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5203 --bidir -B 60.60.0.3  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5204 --bidir -B 60.60.0.4  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5205 --bidir -B 60.60.0.5  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5206 --bidir -B 60.60.0.6  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5207 --bidir -B 60.60.0.7  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5208 --bidir -B 60.60.0.8  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5209 --bidir -B 60.60.0.9  -t 600 -b 50k"&
    kubectl exec $pod -c f5gc-ue-pool-01 -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p 5210 --bidir -B 60.60.0.10 -t 600 -b 50k"&
done

