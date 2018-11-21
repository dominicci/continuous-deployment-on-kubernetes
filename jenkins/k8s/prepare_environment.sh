# CMIS-545 Cloud Computing Architecture Project Scripts
#
# Authur: Samuel Njoku
#
# This script prepares the Cloud SDK environment in the Cloud Shell
echo "Setting default compute zone"
gcloud config set compute/zone us-east1-d

echo "Settind project"
gcloud config set project snjoku-dev

echo "Changind directory to continuous-deployment-on-kubernetes"
gcloud app create --region "us-central"

echo "Exporting GCLOUD_PROJECT"
export GCLOUD_PROJECT=$DEVSHELL_PROJECT_ID