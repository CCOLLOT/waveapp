#!/bin/bash
sudo yum update -y
sudo yum install docker -y 
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker run -p 80:5000  --env BUCKET_NAME=${BUCKET_NAME} ccollot/webapp-formation