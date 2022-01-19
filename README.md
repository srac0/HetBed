# HetBed

HetBed is an application-agnostic framework to experiment with application placement in heterogeneous cloud environments. This repository includes 5G experiments that run on a Kubernetes cluster. Network Functions (NFs) can be deployed according to many architectures, and use case-specific workload can be applied to User Equipements.

## Installation

Steps 1 to 4 can be done with the ansible scripts (available soon).

1. Install Ubuntu server
2. Install [gtp kernel module](https://github.com/free5gc/gtp5g) (on every worker node. Change kernel to meet requirements if needed)
3. Install Docker
4. Install [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) cluster
5. Configure the cluster

```bash
sudo apt install kubectl jq
sudo apt-mark hold linux-aws linux-base linux-headers-aws linux-image-aws
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo usermod -aG docker $USER

# on master node
sudo kubeadm init --control-plane-endpoint=<master-node-address> --pod-network-cidr=172.20.0.0/16 --apiserver-advertise-address=<master-node-ip>

# on worker node
kubeadm join --token <token> <control-plane-host>:<control-plane-port> --discovery-token-ca-cert-hash sha256:<hash> --node-name <worker-name>  # on worker nodes

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy networking
kubectl create -f free5gc-k8s/clusters/cni/calico/01_tigera_operator.yaml

kubectl create -f free5gc-k8s/clusters/cni/calico/02_custom_resources.yaml
watch kubectl get pods -n calico-system # Wait until each pod has the STATUS of Running.
kubectl get nodes -o wide # Confirm that all nodes are up.

# Remove the master taint (if needed)
kubectl taint nodes --all node-role.kubernetes.io/master- 

# Update master node config (if needed)
kubeadm upgrade apply --certificate-renewal=false --config=cluster_setup/kubeadm/single/01_init_defaults.yaml
kubeadm upgrade node --certificate-renewal=false
```

6. Install a registry (or use yours)

```bash
docker run -d --restart always -p 5000:5000 --name registry registry:2
sudo vim /etc/docker/daemon.json
```

add the following entry to /etc/docker/daemon.json

```json
{
  "insecure-registries" : ["ip-10-0-0-10:5000"]
}
```

## 5G Experiments

5G experiments require at least 5 worker nodes (datacenter, cloudlet, edge, gNB, and UE).

### Deployment

```bash
./setup # once the testbed configuration is done
./setup reset # if needed
cd ./experiments/5G_experiment
make all
./scripts/apply.sh # deploy step by step
./scripts/delete.sh # delete deployements
```

### Parameters

#### Config file

Main parameters are defined in *config.cfg*.

| Parameters       | default value     |
| ---------------- | ----------------- |
| docker_registry  | ip-10-0-0-10:5000 |
| master_node_ip   | 10.0.0.10         |
| master_node_name | ip-10-0-0-10      |
| iperf_server_ip  | 10.0.0.100        |
| architecture     | edge_cloudlet     |
| edge_node_ip     | ip-10-0-0-14      |
| cloudlet_node_ip | ip-10-0-0-15      |
| gnb_node_ip      | ip-10-0-0-16      |
| ue_node_ip       | ip-10-0-0-17      |

#### Network Functions fixed IP

| Name  | IP          |
| ----- | ----------- |
| AMF   | 172.20.10.0 |
| AMF-2 | 172.20.10.1 |
| UPF   | 172.20.20.0 |
| UPF-2 | 172.20.20.1 |
| SMF   | 172.20.30.0 |
| SMF-2 | 172.20.30.0 |
| gNB   | 172.20.40.0 |
| gNB-2 | 172.20.40.1 |

#### Cluster properties

Cluster architecture can be set in the config file. The default architecture includes data center, edge and, cloudlet nodes.

#### Network properties

Edit *experiments/5G_experiment/scripts/network_control.sh* parameters to set additional latency and maximum bandwidth.

```bash
LATENCY_CORE="0ms" # between the cloudlet and data center nodes
LATENCY_N2="0ms"
LATENCY_N3="0ms"
LATENCY_N4="0ms"
RATE_UPF="100mbit"
RATE_GNB="100mbit"
```

#### Scripts

Many utilies scripts can be found in *experiments/5G_experiment/scripts/*.

### Deploying UEs

#### Pool deployment

A *pool* of UEs (pod with many UEs) can be deployed using the following command. Then, use *apply.sh*.

```bash
cd experiments/5G_experiment/
./scripts/ue/ue-generator.sh <pool-name> <first-imsi-of-the-pool> <nb-of-ues-in-the-pool>
# E.g. for 200 UEs in 20 pools.
./scripts/ue/ue-generator.sh ue-pool-01 imsi-208930000000000 10
./scripts/ue/ue-generator.sh ue-pool-02 imsi-208930000000010 10
./scripts/ue/ue-generator.sh ue-pool-03 imsi-208930000000020 10
./scripts/ue/ue-generator.sh ue-pool-04 imsi-208930000000030 10
./scripts/ue/ue-generator.sh ue-pool-05 imsi-208930000000040 10
./scripts/ue/ue-generator.sh ue-pool-06 imsi-208930000000050 10
./scripts/ue/ue-generator.sh ue-pool-07 imsi-208930000000060 10
./scripts/ue/ue-generator.sh ue-pool-08 imsi-208930000000070 10
./scripts/ue/ue-generator.sh ue-pool-09 imsi-208930000000080 10
./scripts/ue/ue-generator.sh ue-pool-10 imsi-208930000000090 10
./scripts/ue/ue-generator.sh ue-pool-11 imsi-208930000000100 10
./scripts/ue/ue-generator.sh ue-pool-12 imsi-208930000000110 10
./scripts/ue/ue-generator.sh ue-pool-13 imsi-208930000000120 10
./scripts/ue/ue-generator.sh ue-pool-14 imsi-208930000000130 10
./scripts/ue/ue-generator.sh ue-pool-15 imsi-208930000000140 10
./scripts/ue/ue-generator.sh ue-pool-16 imsi-208930000000150 10
./scripts/ue/ue-generator.sh ue-pool-17 imsi-208930000000160 10
./scripts/ue/ue-generator.sh ue-pool-18 imsi-208930000000170 10
./scripts/ue/ue-generator.sh ue-pool-19 imsi-208930000000180 10
./scripts/ue/ue-generator.sh ue-pool-20 imsi-208930000000190 10
```

#### Generate traffic on UEs

- Setup your iperf server ip in the config. It should be available from your cluster.
- Run iperf server

```bash
cd experiments/5G_experiment/images/iperf
docker-compose -f docker-compose-50.yaml build
docker-compose -f docker-compose-50.yaml up
```

- Run one of the scripts in *experiments/5G_experiment/scripts/ue-traffic*.

## Development

### Adding a new architecture

Update: node_manager/architecture_selector.sh

### Adding a new experiment

Follow 5G experiments methodology:

- Build Docker images

- Write down manifests

- Update scripts

## References

- [free5gc](https://github.com/free5gc/free5gc)

- [ueransim](https://github.com/aligungr/UERANSIM)

- [free5gc-compose](https://github.com/free5gc/free5gc-compose)

- [free5gc-k8s](https://github.com/sumichaaan/free5gc-k8s)
