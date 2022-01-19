#! /bin/bash

FILE="names.txt"

if [ ! -d data/records ] ; then
  mkdir -p data/records
else
  rm data/records/*.pcap
  rm data/records/$FILE
fi
if [ -f data/records/ip.tmp ] ; then
  rm data/records/ip.tmp
fi

for pod in `kubectl get po --namespace f5gc -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
  # Start recording
  kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "tcpdump -i any -s0 -nn -w /tmp/k8s.pcap &"
done

read -n 1 -s -r -p "Press any key to stop recording"

for pod in `kubectl get po --namespace f5gc -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
  # Stop recording
  kubectl exec $pod -c tcpdump -n f5gc -- /bin/sh -c "pgrep tcpdump | xargs kill -15"
  # Save records
  kubectl cp "$pod:tmp/k8s.pcap" "data/records/$pod.pcap" -c tcpdump -n f5gc
  # Add IP and name
  hostIP=$(kubectl get --namespace f5gc -o json pod $pod | jq '.status.hostIP' | sed 's/"//g')
  podIP=$(kubectl get --namespace f5gc -o json pod $pod | jq '.status.podIP' | sed 's/"//g')
  echo -e "$pod |  hostIP: $hostIP  |  podIP: $podIP" >> data/records/ip.tmp
done

# Align text
column -t -s '|' data/records/ip.tmp > data/records/$FILE
rm data/records/ip.tmp
