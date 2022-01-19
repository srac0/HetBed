#! /bin/bash

APPLY="./scripts/apply.sh"
DELETE="./scripts/delete.sh"

# reset all node taints
reset () {
    echo "Reset"
    for node in `kubectl get node -o json |  jq '.items[] | .metadata.name' | sed 's/"//g'` ; do
        kubectl taint nodes $node dedicated=gNB:NoSchedule-
        kubectl taint nodes $node dedicated=DC:NoSchedule-
        kubectl taint nodes $node dedicated=Edge:NoSchedule-
        kubectl taint nodes $node dedicated=UE:NoSchedule-
        kubectl taint nodes $node dedicated=Cloudlet:NoSchedule-
        kubectl label nodes $node nodetype-
    done
}

invalid_args () {
    echo "scenario_selector: <option>"
    echo "  reset: clear all taints and labels"
    echo "  edge_cloudlet: select scenario"
    exit 1
}

edge_cloudlet () {
    reset
    echo "edge_cloudlet"
    # taint
    kubectl taint nodes ip-10-0-0-14 dedicated=Edge:NoSchedule
    kubectl taint nodes ip-10-0-0-15 dedicated=Cloudlet:NoSchedule
    kubectl taint nodes ip-10-0-0-16 dedicated=gNB:NoSchedule
    kubectl taint nodes ip-10-0-0-17 dedicated=UE:NoSchedule
    # affinity
    kubectl label nodes ip-10-0-0-14 nodetype=upf
    kubectl label nodes ip-10-0-0-15 nodetype=cloudlet
    kubectl label nodes ip-10-0-0-16 nodetype=gnb
    kubectl label nodes ip-10-0-0-17 nodetype=ue
}

if [[ ! $# -eq 1 ]] ; then
    echo "Invalid args: $#"
    invalid_args
fi

if [[ "$1" == "reset" ]] ; then
    reset
    exit 0
fi

if [[ "$1" == "show" ]] ; then
    kubectl get nodes -o json | jq '.items[].spec.taints'
    kubectl get nodes --show-labels
    exit 0
fi

if [[ "$1" == "edge_cloudlet" ]] ; then
    edge_cloudlet
    exit 0
else
    echo "Unknown arg: $1"
    invalid_args
fi
