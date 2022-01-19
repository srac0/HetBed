#! /bin/bash

LATENCY_CORE="0ms" # between the cloudlet and data center nodes
LATENCY_N2="0ms"
LATENCY_N3="0ms"
LATENCY_N4="0ms"
RATE_UPF="100mbit"
RATE_GNB="100mbit"

echo "UPF"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-upf -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.0/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.1/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.2/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.3/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.4/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.5/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.30.0/32 flowid 1:2" # N4
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.30.1/32 flowid 1:2" # N4
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N3 rate $RATE_UPF"
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N4 rate $RATE_UPF"
kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"
# kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"

pod=$(kubectl get po --namespace f5gc -l app=f5gc-upf-2 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.0/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.1/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.2/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.3/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.4/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.40.5/32 flowid 1:1" # N3
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.30.0/32 flowid 1:2" # N4
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.30.1/32 flowid 1:2" # N4
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N3 rate $RATE_UPF"
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N4 rate $RATE_UPF"
kubectl exec $pod -c f5gc-upf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"
# kubectl exec $pod -c f5gc-upf -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"

echo "AMF"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-amf -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.0/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.1/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.2/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.3/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.4/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.5/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:2" # default (core)
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_N2"
kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_CORE"
# kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"

pod=$(kubectl get po --namespace f5gc -l app=f5gc-amf-2 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.0/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.1/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.2/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.3/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.4/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.40.5/32 flowid 1:3" # N2
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:2" # default (core)
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_N2"
kubectl exec $pod -c f5gc-amf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_CORE"
# kubectl exec $pod -c f5gc-amf -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"

echo "SMF"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-smf -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:3" # N4
kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:3" # N4
kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:2" # default (core)
kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_N4"
kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_CORE"
# kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"

pod=$(kubectl get po --namespace f5gc -l app=f5gc-smf-2 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-smf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-smf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:3" # N4
kubectl exec $pod -c f5gc-smf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:3" # N4
kubectl exec $pod -c f5gc-smf-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:2" # default (core)
kubectl exec $pod -c f5gc-smf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_N4"
kubectl exec $pod -c f5gc-smf-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_CORE"
# kubectl exec $pod -c f5gc-smf -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"

echo "gNB"
pod=$(kubectl get po --namespace f5gc -l app=ueransim-gnb-o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.0/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.1/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N2 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N3 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"
# kubectl exec $pod -c ueransim-gnb-n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"

pod=$(kubectl get po --namespace f5gc -l app=ueransim-gnb-2 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.0/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.1/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N2 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N3 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"
# kubectl exec $pod -c ueransim-gnb-2 -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"
pod=$(kubectl get po --namespace f5gc -l app=ueransim-gnb-3 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.0/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.1/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N2 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N3 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"
# kubectl exec $pod -c ueransim-gnb-3 -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"
pod=$(kubectl get po --namespace f5gc -l app=ueransim-gnb-4 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.0/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.1/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N2 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N3 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"
# kubectl exec $pod -c ueransim-gnb-4 -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"
pod=$(kubectl get po --namespace f5gc -l app=ueransim-gnb-5 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.0/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.1/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N2 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N3 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"
# kubectl exec $pod -c ueransim-gnb-5 -n f5gc -- /bin/bash -c "tc qdisc del dev eth0 root # delete all rules"
pod=$(kubectl get po --namespace f5gc -l app=ueransim-gnb-6 -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.0/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 172.20.10.1/32 flowid 1:1" # N2
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.0/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1: prio 2 u32 match ip dst 172.20.20.1/32 flowid 1:2" # N3
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol all parent 1: prio 3 u32 match ip dst 0.0.0.0/0 flowid 1:3" # default
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:1 handle 10: netem delay $LATENCY_N2 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:2 handle 20: netem delay $LATENCY_N3 rate $RATE_GNB"
kubectl exec $pod -c ueransim-gnb-6 -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: sfq"

echo "NRF"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-nrf -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-nrf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-nrf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.0/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-nrf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.1/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-nrf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.0/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-nrf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.1/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-nrf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_CORE"

echo "UDR"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-udr -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-udr -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-udr -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.0/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-udr -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.1/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-udr -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.0/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-udr -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.1/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-udr -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_CORE"

echo "UDM"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-udm -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-udm -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-udm -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.0/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-udm -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.1/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-udm -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.0/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-udm -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.1/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-udm -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_CORE"

echo "AUSF"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-ausf -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-ausf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-ausf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.0/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-ausf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.1/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-ausf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.0/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-ausf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.1/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-ausf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_CORE"

echo "NSSF"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-nssf -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-nssf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-nssf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.0/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-nssf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.1/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-nssf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.0/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-nssf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.1/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-nssf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_CORE"

echo "PCF"
pod=$(kubectl get po --namespace f5gc -l app=f5gc-pcf -o json |  jq '.items[] | .metadata.name' | sed 's/"//g')
kubectl exec $pod -c f5gc-pcf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 root handle 1: prio"
kubectl exec $pod -c f5gc-pcf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.0/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-pcf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.10.1/32 flowid 1:3" # AMF
kubectl exec $pod -c f5gc-pcf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.0/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-pcf -n f5gc -- /bin/bash -c "tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.20.30.1/32 flowid 1:3" # SMF
kubectl exec $pod -c f5gc-pcf -n f5gc -- /bin/bash -c "tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $LATENCY_CORE"
