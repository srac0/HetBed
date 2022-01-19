#! /bin/bash

FILE="names.txt"

if [ ! -d data/logs ] ; then
  mkdir -p data/logs
else
  rm data/logs/*.txt
  # rm logs/$FILE
fi
if [ -f data/logs/ip.tmp ] ; then
  rm data/logs/ip.tmp
fi

for pod in `kubectl get po --namespace f5gc -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
  # Get logs	
  kubectl logs $pod -n f5gc --all-containers=true >> "data/logs/$pod.txt"
  # Add IP and name
  hostIP=$(kubectl get --namespace f5gc -o json pod $pod | jq '.status.hostIP' | sed 's/"//g')
  podIP=$(kubectl get --namespace f5gc -o json pod $pod | jq '.status.podIP' | sed 's/"//g')
  echo -e "$pod |  hostIP: $hostIP  |  podIP: $podIP" >> data/logs/ip.tmp
done

# Align text
column -t -s '|' data/logs/ip.tmp > data/logs/$FILE
rm data/logs/ip.tmp
