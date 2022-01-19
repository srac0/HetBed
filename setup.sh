#! /bin/bash

if [[ "$1" == "reset" ]] ; then
    ./node_manager/architecture_selector.sh reset
    git reset --hard
    exit 0
fi

source config.cfg
find . -type f -not -path '*/\.*' -exec sed -i "s/ip-10-0-0-10:5000/$docker_registry/g" {} + 
find . -type f -not -path '*/\.*' -exec sed -i "s/10\.0\.0\.100/$iperf_server_ip/g" {} +
find . -type f -not -path '*/\.*' -exec sed -i "s/10\.0\.0\.10/$master_node_ip/g" {} +
find . -type f -not -path '*/\.*' -exec sed -i "s/ip-10-0-0-10/$master_node_name/g" {} +
find . -type f -not -path '*/\.*' -exec sed -i "s/ip-10-0-0-14/$edge_node_ip/g" {} +
find . -type f -not -path '*/\.*' -exec sed -i "s/ip-10-0-0-15/$cloudlet_node_ip/g" {} +
find . -type f -not -path '*/\.*' -exec sed -i "s/ip-10-0-0-16/$gnb_node_ip/g" {} +
find . -type f -not -path '*/\.*' -exec sed -i "s/ip-10-0-0-17/$ue_node_ip/g" {} +
./node_manager/architecture_selector.sh $architecture