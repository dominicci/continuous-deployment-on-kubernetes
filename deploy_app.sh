# CMIS-545 Cloud Computing Architecture Project Scripts
# Date: 2018-11-20
# Authur: Samuel Njoku
#
# This script deploys the sample app to K8
echo "Create the namespace for production"
kubectl create ns production

echo "Create the canary and production Deployments and Services"
kubectl --namespace=production apply -f k8s/production
kubectl --namespace=production apply -f k8s/canary
kubectl --namespace=production apply -f k8s/services

echo "Scale the production service"
kubectl --namespace=production scale deployment gceme-frontend-production --replicas=4

echo "Retrieve the External IP for the production services"
kubectl --namespace=production get service gceme-frontend

echo "Confirm that both services are working by opening the frontend external IP in your browser"
sleep 15; echo "\a"