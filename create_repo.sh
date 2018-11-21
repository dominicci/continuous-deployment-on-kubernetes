# CMIS-545 Cloud Computing Architecture Project Scripts
# Date: 2018-11-20
# Authur: Samuel Njoku
#
# This script creates a repository for the sample app source
echo "Go to Google Cloud Platform > Tools > Development and under repositories..."
echo "create an empty repository called <default>"
sleep 15; echo "\a"

echo "Change directories to sample-app of the repo you cloned previously"
sleep 5; echo "\a"

echo "Initialize the git repository"
git init
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/snjoku-dev/r/default

echo "Ensure git is able to identify you"
git config --global user.email "samuelnjoku@gmail.com"
git config --global user.name "dominicci"

echo "Add, commit, and push all the files"
git add .
git commit -m "Initial commit"
git push origin master
sleep 15; echo "\a"