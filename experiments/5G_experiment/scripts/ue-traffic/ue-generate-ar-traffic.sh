#! /bin/bash

# send data to DN

# ./build/nr-cli imsi-208930000000000 -e commands
# ./build/nr-cli imsi-208930000000000 -e "ps-list"
# ./build/nr-cli imsi-208930000000000 -e "ps-establish IPv4 --sst 1 --sd 0x010203 --dnn internet"
# ./build/nr-cli imsi-208930000000000 -e "ps-establish IPv4 --sst 2 --sd 0x112233 --dnn internet"
# ./build/nr-cli imsi-208930000000000 -e "ps-release 2"
# ./build/nr-cli imsi-208930000000000 -e "ps-release-all"

LOAD_SIZE="230M" # 460M / 2 because bid=dir
LOAD_BANDWIDTH="100M"
IPERF_PORTS=(5201 5202 5203 5204 5205 5206 5207 5208 5209 5210 5211 5212 5213 5214 5215 5216 5217 5218 5219 5220)
IPERF_PORT=0

send_load() {
    # $1 pod
    # $2 IMSI
    # $3 IPERF_PORT
    IP=`kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "./build/nr-cli $IMSI -e 'ps-list' | grep address | yq e '.address' -"` # get the last established session IP
    echo $IP
    # Check if PDU session established
    while [ "null" = $IP ]|| [ -z "$IP" ]; do 
        sleep 1
        IP=`kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "./build/nr-cli $IMSI -e 'ps-list' | grep address | yq e '.address' -"`
        # echo $IP
    done
    echo "$IP, iperf: ${IPERF_PORTS[$IPERF_PORT]}"
    kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p ${IPERF_PORTS[$IPERF_PORT]} --bidir -B $IP -n $LOAD_SIZE -b $LOAD_BANDWIDTH"
}

for pod in `kubectl get po --namespace f5gc -l exp=exp-03-ue -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
    echo "Pod: $pod"
    if [[ "$pod" == *"f5gc-ue-pool-01"* ]]; then
        for IMSI in "imsi-208930000000000" "imsi-208930000000001" "imsi-208930000000002"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
done

