#! /bin/bash

APPLY="./scripts/apply.sh"
DELETE="./scripts/delete.sh"
DEST="UEs"
UE_NAME=$1
UE_IMSI=$2
POOL_SIZE=$3
GNB_IP=$4

invalid_args () {
    echo "ue-generator: reset"
    echo "ue-generator: <name> <imsi> <pool-size>"
    exit 1
}
if [[ $# -eq 1 ]] ; then
    if [[ "$1" == "reset" ]] ; then
        rm -fr $DEST
        git checkout $APPLY
        git checkout $DELETE
	exit 0
    else
    	echo "Invalid args: $#"
        invalid_args
    fi
fi

if [[ ! $# -eq 3 ]] ; then
    echo "Invalid args: $#"
    invalid_args
fi


mkdir -p "$DEST/$UE_NAME"
cp ./scripts/ueransim-ue-pool-template/* "$DEST/$UE_NAME"
find "$DEST/$UE_NAME" -type f -not -path '*/\.*' -exec sed -i "s/ueransim-ue/$UE_NAME/g" {} + # manifest
find "$DEST/$UE_NAME" -type f -not -path '*/\.*' -exec sed -i "s/imsi-208930000000000/$UE_IMSI/g" {} + # imsi
find "$DEST/$UE_NAME" -type f -not -path '*/\.*' -exec sed -i "s/pool-size/$POOL_SIZE/g" {} + # pool size


echo 'read -n 1 -s -r -p "Press any key to continue"' >> $APPLY
echo "kubectl apply -k ./$DEST/$UE_NAME/" >> $APPLY
echo "kubectl delete -k ./$DEST/$UE_NAME/" >> $DELETE
