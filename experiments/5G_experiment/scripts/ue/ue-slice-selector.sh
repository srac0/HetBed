#! /bin/bash

POOLS=("f5gc-ue-pool-02" "f5gc-ue-pool-04" "f5gc-ue-pool-06" "f5gc-ue-pool-08" "f5gc-ue-pool-10" "f5gc-ue-pool-12" "f5gc-ue-pool-14" "f5gc-ue-pool-16" "f5gc-ue-pool-18" "f5gc-ue-pool-20")

for pool in ${POOLS[@]}; do
    echo $pool
    find UEs/$pool -type f -not -path '*/\.*' -exec sed -i 's/sst: 0x01/sst: 0x02/g' {} +
    find UEs/$pool -type f -not -path '*/\.*' -exec sed -i 's/sd: 0x010203/sd: 0x112233/g' {} +
done
