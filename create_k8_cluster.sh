# CMIS-545 Cloud Computing Architecture Project Scripts
#
# Authur: Samuel Njoku
#
# This script creates the Kubernetes cluster
echo "Creating a Compute Engine network for the GKE cluster to connect to and use"
gcloud compute networks create jenkins

echo "Provisioning a Kubernetes cluster using Kubernetes Engine"
gcloud container clusters create jenkins-cd \
  --network jenkins --machine-type n1-standard-2 --num-nodes 2 \
  --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw,cloud-platform"

echo "Confirming that your cluster is running"
gcloud container clusters list

echo "Checking the number of nodes to confirm that you can connect to your cluster"
kubectl get nodes
sleep 120; echo "\a"
kubectl get nodes