# CMIS-545 Cloud Computing Architecture Project Scripts
#
# Authur: Samuel Njoku
#
# This script creates the Jenkins service
echo "Confirming Jenkins pod goes to the Running state and the container is in the READY state"
kubectl get nodes
sleep 120; echo "\a"
kubectl get nodes

echo "Creating the jenkins namespace"
kubectl create ns jenkins

echo "Creating the Jenkins Home Volume"
gcloud compute images create jenkins-home-image --source-uri https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz
gcloud compute disks create jenkins-home --image jenkins-home-image

echo "Creating a Jenkins Deployment and Service and generating a random password"
PASSWORD=`openssl rand -base64 15`; echo "Your password is $PASSWORD"; sed -i.bak s#CHANGE_ME#$PASSWORD# jenkins/k8s/options

echo "Lets give him a chance to catch his breath..."
sleep 120; echo "\a"

echo "Now create the secret using kubectl"
kubectl create secret generic jenkins --from-file=jenkins/k8s/options --namespace=jenkins

echo "Add yourself as a cluster administrator in the cluster's RBAC..."
echo "...so that you can give Jenkins permissions in the cluster"
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)

echo "Lets give him another breather..."
sleep 120; echo "\a"

echo "Create the Jenkins Deployment and Services and confirm the pod was scheduled"
kubectl apply -f jenkins/k8s/

echo "Check that your master pod is in the running state"
kubectl get pods --namespace jenkins
sleep 60; echo "\a"
kubectl get pods --namespace jenkins

echo "Now, check that the Jenkins Service was created properly"
kubectl get svc --namespace jenkins
sleep 60; echo "\a"
kubectl get svc --namespace jenkins

echo "Use the K8 secrets API to add your certs securely to your cluster for Ingress to use"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=jenkins/O=jenkins"

echo "Now upload them to K8 as secrets"
kubectl create secret generic tls --from-file=/tmp/tls.crt --from-file=/tmp/tls.key --namespace jenkins

echo "Now that the secrets have been uploaded, create the ingress load balancer"
kubectl apply -f jenkins/k8s/lb
sleep 60; echo "\a"

echo "what a RUSH!!!"