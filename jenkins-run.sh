#!/bin/bash

# Building docker image 
docker build -t jenkins-test .

# Running dokcer image on port 8080 
docker run --name=app -itd -p 8080:8080 jenkins-test
#check it the container and port  is up and running 
# Providing sleep to jenkins to start 
sleep 40

# executing jenkins jobs inside jenkins
docker exec app  jenkins-jobs --conf /etc/jenkins_jobs/jenkins_jobs.ini --user=admin --password=admin123 update jobs
