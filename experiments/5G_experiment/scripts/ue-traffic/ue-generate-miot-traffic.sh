#! /bin/bash

# establish PDU session, send data to DN and close PDU session

# ./build/nr-cli imsi-208930000000000 -e commands
# ./build/nr-cli imsi-208930000000000 -e "ps-list"
# ./build/nr-cli imsi-208930000000000 -e "ps-establish IPv4 --sst 1 --sd 0x010203 --dnn internet"
# ./build/nr-cli imsi-208930000000000 -e "ps-establish IPv4 --sst 2 --sd 0x112233 --dnn internet"
# ./build/nr-cli imsi-208930000000000 -e "ps-release 2"
# ./build/nr-cli imsi-208930000000000 -e "ps-release-all"

LOAD_SIZE="64K"
LOAD_BANDWIDTH="100M"
IPERF_PORTS=(5201 5202 5203 5204 5205 5206 5207 5208 5209 5210 5211 5212 5213 5214 5215 5216 5217 5218 5219 5220 5221 5222 5223 5224 5225 5226 5227 5228 5229 5230 5231 5232 5233 5234 5235 5236 5237 5238 5239 5240 5241 5242 5243 5244 5245 5246 5247 5248 5249 5250 5251 5252 5253 5254 5255 5256 5257 5258 5259 5260 5261 5262 5263 5264 5265 5266 5267 5268 5269 5270 5271 5272 5273 5274 5275 5276 5277 5278 5279 5280 5281 5282 5283 5284 5285 5286 5287 5288 5289 5290 5291 5292 5293 5294 5295 5296 5297 5298 5299 5300)
IPERF_PORT=0

send_load() {
    # $1 pod
    # $2 IMSI
    # $3 IPERF_PORT
    # PDU establishment request
    IP=`kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "./build/nr-cli $IMSI -e 'ps-list' | grep address | yq e '.address' -"` # get the last established session IP
    echo $IP
    # Check if PDU session established
    MAX_RETRY=0
    while [ "null" = $IP ] || [ -z "$IP" ]; do 
        sleep 1
        IP=`kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "./build/nr-cli $IMSI -e 'ps-list' | grep address | yq e '.address' -"`
        # echo $IP
	if [[ MAX_RETRY -gt 30 ]]; then
	    echo "Too much retries"
	    exit 1
	fi
	MAX_RETRY=$((MAX_RETRY+1))
    done
    echo "$IP, iperf: ${IPERF_PORTS[$IPERF_PORT]}"
    kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "iperf3 -c 10.0.0.100 -p ${IPERF_PORTS[$IPERF_PORT]} --bidir -B $IP -n $LOAD_SIZE -b $LOAD_BANDWIDTH"
}

for pod in `kubectl get po --namespace f5gc -l exp=exp-03-ue -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
    echo "Pod: $pod"
    # kubectl delete pods -n f5gc --force $pod
    kubectl exec $pod -c f5gc-ue -n f5gc -- /bin/bash -c "kill -15 1"
    if [[ "$pod" == *"f5gc-ue-pool-01"* ]]; then
        for IMSI in "imsi-208930000000000" "imsi-208930000000001" "imsi-208930000000002" "imsi-208930000000003" "imsi-208930000000004" "imsi-208930000000005" "imsi-208930000000006" "imsi-208930000000007" "imsi-208930000000008" "imsi-208930000000009"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi

    if [[ "$pod" == *"f5gc-ue-pool-02"* ]]; then
        for IMSI in "imsi-208930000000010" "imsi-208930000000011" "imsi-208930000000012" "imsi-208930000000013" "imsi-208930000000014" "imsi-208930000000015" "imsi-208930000000016" "imsi-208930000000017" "imsi-208930000000018" "imsi-208930000000019"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-03"* ]]; then
        for IMSI in "imsi-208930000000020" "imsi-208930000000021" "imsi-208930000000022" "imsi-208930000000023" "imsi-208930000000024" "imsi-208930000000025" "imsi-208930000000026" "imsi-208930000000027" "imsi-208930000000028" "imsi-208930000000029"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-04"* ]]; then
        for IMSI in "imsi-208930000000030" "imsi-208930000000031" "imsi-208930000000032" "imsi-208930000000033" "imsi-208930000000034" "imsi-208930000000035" "imsi-208930000000036" "imsi-208930000000037" "imsi-208930000000038" "imsi-208930000000039"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-05"* ]]; then
        for IMSI in "imsi-208930000000040" "imsi-208930000000041" "imsi-208930000000042" "imsi-208930000000043" "imsi-208930000000044" "imsi-208930000000045" "imsi-208930000000046" "imsi-208930000000047" "imsi-208930000000048" "imsi-208930000000049"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-06"* ]]; then
        for IMSI in "imsi-208930000000050" "imsi-208930000000051" "imsi-208930000000052" "imsi-208930000000053" "imsi-208930000000054" "imsi-208930000000055" "imsi-208930000000056" "imsi-208930000000057" "imsi-208930000000058" "imsi-208930000000059"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-07"* ]]; then
        for IMSI in "imsi-208930000000060" "imsi-208930000000061" "imsi-208930000000062" "imsi-208930000000063" "imsi-208930000000064" "imsi-208930000000065" "imsi-208930000000066" "imsi-208930000000067" "imsi-208930000000068" "imsi-208930000000069"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-08"* ]]; then
        for IMSI in "imsi-208930000000070" "imsi-208930000000071" "imsi-208930000000072" "imsi-208930000000073" "imsi-208930000000074" "imsi-208930000000075" "imsi-208930000000076" "imsi-208930000000077" "imsi-208930000000078" "imsi-208930000000079"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-09"* ]]; then
        for IMSI in "imsi-208930000000080" "imsi-208930000000081" "imsi-208930000000082" "imsi-208930000000083" "imsi-208930000000084" "imsi-208930000000085" "imsi-208930000000086" "imsi-208930000000087" "imsi-208930000000088" "imsi-208930000000089"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    if [[ "$pod" == *"f5gc-ue-pool-10"* ]]; then
        for IMSI in "imsi-208930000000090" "imsi-208930000000091" "imsi-208930000000092" "imsi-208930000000093" "imsi-208930000000094" "imsi-208930000000095" "imsi-208930000000096" "imsi-208930000000097" "imsi-208930000000098" "imsi-208930000000099"
        do
            echo $IMSI
            send_load $pod $IMSI $IPERF_PORT&
            IPERF_PORT=$((IPERF_PORT+1))
        done
    fi
    # if [[ "$pod" == *"f5gc-ue-pool-11"* ]]; then
    #     for IMSI in "imsi-208930000000100" "imsi-208930000000101" "imsi-208930000000102" "imsi-208930000000103" "imsi-208930000000104" "imsi-208930000000105" "imsi-208930000000106" "imsi-208930000000107" "imsi-208930000000108" "imsi-208930000000109"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-12"* ]]; then
    #     for IMSI in "imsi-208930000000110" "imsi-208930000000111" "imsi-208930000000112" "imsi-208930000000113" "imsi-208930000000114" "imsi-208930000000115" "imsi-208930000000116" "imsi-208930000000117" "imsi-208930000000118" "imsi-208930000000119"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-13"* ]]; then
    #     for IMSI in "imsi-208930000000120" "imsi-208930000000121" "imsi-208930000000122" "imsi-208930000000123" "imsi-208930000000124" "imsi-208930000000125" "imsi-208930000000126" "imsi-208930000000127" "imsi-208930000000128" "imsi-208930000000129"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-14"* ]]; then
    #     for IMSI in "imsi-208930000000130" "imsi-208930000000131" "imsi-208930000000132" "imsi-208930000000133" "imsi-208930000000134" "imsi-208930000000135" "imsi-208930000000136" "imsi-208930000000137" "imsi-208930000000138" "imsi-208930000000139"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-15"* ]]; then
    #     for IMSI in "imsi-208930000000140" "imsi-208930000000141" "imsi-208930000000142" "imsi-208930000000143" "imsi-208930000000144" "imsi-208930000000145" "imsi-208930000000146" "imsi-208930000000147" "imsi-208930000000148" "imsi-208930000000149"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-16"* ]]; then
    #     for IMSI in "imsi-208930000000150" "imsi-208930000000151" "imsi-208930000000152" "imsi-208930000000153" "imsi-208930000000154" "imsi-208930000000155" "imsi-208930000000156" "imsi-208930000000157" "imsi-208930000000158" "imsi-208930000000159"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-17"* ]]; then
    #     for IMSI in "imsi-208930000000160" "imsi-208930000000161" "imsi-208930000000162" "imsi-208930000000163" "imsi-208930000000164" "imsi-208930000000165" "imsi-208930000000166" "imsi-208930000000167" "imsi-208930000000168" "imsi-208930000000169"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-18"* ]]; then
    #     for IMSI in "imsi-208930000000170" "imsi-208930000000171" "imsi-208930000000172" "imsi-208930000000173" "imsi-208930000000174" "imsi-208930000000175" "imsi-208930000000176" "imsi-208930000000177" "imsi-208930000000178" "imsi-208930000000179"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-19"* ]]; then
    #     for IMSI in "imsi-208930000000180" "imsi-208930000000181" "imsi-208930000000182" "imsi-208930000000183" "imsi-208930000000184" "imsi-208930000000185" "imsi-208930000000186" "imsi-208930000000187" "imsi-208930000000188" "imsi-208930000000189"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
    # if [[ "$pod" == *"f5gc-ue-pool-20"* ]]; then
    #     for IMSI in "imsi-208930000000190" "imsi-208930000000191" "imsi-208930000000192" "imsi-208930000000193" "imsi-208930000000194" "imsi-208930000000195" "imsi-208930000000196" "imsi-208930000000197" "imsi-208930000000198" "imsi-208930000000199"
    #     do
    #         echo $IMSI
    #         send_load $pod $IMSI $IPERF_PORT&
    #         IPERF_PORT=$((IPERF_PORT+1))
    #     done
    # fi
done

