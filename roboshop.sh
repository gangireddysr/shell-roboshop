#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0fa27da592684b3f7"
#ZONE_ID="Z09552593JUGZ1EDVVGFV" 
#DOMAIN_NAME="purini.shop"

for instace in $@

do
     INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)


      INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)

    # Get Private IP
    if [ $instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
       # RECORD_NAME="$instance.$DOMAIN_NAME" 
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
       # RECORD_NAME="$DOMAIN_NAME" 
    fi

    

done