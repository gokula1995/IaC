#!/bin/sh

##################################################CLUSTER-STACK-CREATION##################################################################

### The below template creates ecs cluster with Network Load balacner
##### Specify the instance type, vpc range as per your requirements


echo "---------------------------------------------------\n"
echo "ECS Cluster Infrastructure Creation is started\n"
echo "---------------------------------------------------\n"


export ENVIRONMENT_NAME=SAMPLE-DEMO && INSTANCE_TYPE=t2.micro && CLUSTER_MIN_SIZE=1 && CLUSTER_MAX_SIZE=4 \
        SUBNET_A=subnet-0262156163ceca7bf && SUBNET_B=subnet-05309102d73f0ccdf && VPC_ID=vpc-cec4e7a6 \
        VPC_CIDR=172.31.0.0/16 && VOLUME_SIZE=22 && NAME_SPACE=green

        

aws cloudformation deploy --profile gokula \
--stack-name $ENVIRONMENT_NAME \
--template-file ./ecs-cluster.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides "ServiceCount=1" "EnvironmentName=$ENVIRONMENT_NAME" "KeyName=$ENVIRONMENT_NAME" "InstanceType=$INSTANCE_TYPE" \
    "ClusterMinSize=$CLUSTER_MIN_SIZE" "ClusterMaxSize=$CLUSTER_MAX_SIZE" "Subnet1=$SUBNET_A" "Subnet2=$SUBNET_B" "VpcId=$VPC_ID" \
    "VpcCIDR=$VPC_CIDR" "EbsVolumeSize=$VOLUME_SIZE" "Route53NameSpace=$NAME_SPACE"

##################################################UNIFIEDAPI-STACK-CREATION##################################################################

## The below template creates NLB target group, Service, Service Discovery, target Scaling, Cloudwatch Alarms
#### Change the profile name as per your aws cli local config name 

echo "---------------------------------------------------\n"
echo "Parser Service Creation is started\n"
echo "---------------------------------------------------\n"


export SERVICE_NAME=sample && LOG_GROUP=/dev/sample && REPOSITORY=sample && TASK_DEFINITION=sample \
        CONTAINER_NAME=sample && CONTAINER_PORT=8080 && REGION=ap-south-1 && TASK_CPU=128 && TASK_MEMORY=128 && SOFT_LIMIT=128 \
        SERVICE_STACK=sample && LISTENER_PORT=8001
       

## Update the Unified Servie and Task Definition Stack
aws cloudformation deploy --profile gokula \
--stack-name $SERVICE_STACK \
--template-file ,/service.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides "ServiceName=$SERVICE_NAME" "LogGroupName=$LOG_GROUP" "RepositoryName=$REPOSITORY" "TaskDefName=$TASK_DEFINITION" "ContainerName=$CONTAINER_NAME" "ContainerPort=$CONTAINER_PORT" "Region=$REGION" "TaskCPU=$TASK_CPU" "TaskMemory=$TASK_MEMORY" "SoftLimit=$SOFT_LIMIT" "ECSStackName=$ENVIRONMENT_NAME" "ListenerPort=$LISTENER_PORT"