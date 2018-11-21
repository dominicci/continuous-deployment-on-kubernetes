# CMIS-545 Cloud Computing Architecture Project Scripts
# Date: 2018-11-20
# Authur: Samuel Njoku
#
# This script deploys an ingress resource and connects to Jenkins
echo "Retrieving the admin password"
PASSWORD=`openssl rand -base64 15`; echo "Your password is $PASSWORD"; sed -i.bak s#CHANGE_ME#$PASSWORD# jenkins/k8s/options

# echo "Setting up port forwarding to the Jenkins UI from Cloud Shell"
# export POD_NAME=$(kubectl get pods -l "component=cd-jenkins-master" -o jsonpath="{.items# [0].metadata.name}")
# kubectl port-forward $POD_NAME 8080:8080 >> /dev/null &

echo "Now find the load balancer IP address of your Ingress service"
kubectl get ingress --namespace jenkins

echo "The loadbalancer will begin health checks against your Jenkins instance"
kubectl describe ingress jenkins --namespace jenkins

echo "Once the checks go to healthy you will be able to access your Jenkins instance"
echo "Lets give it a moment to catch its breath..."
sleep 15; echo "\a"
kubectl describe ingress jenkins --namespace jenkins