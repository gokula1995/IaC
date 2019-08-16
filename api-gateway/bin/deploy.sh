#!/bin/sh
#set -o errexit -o xtrace

echo "Please select the environment you want to deploy:"
echo "-------------------------------------------------------\n"
echo "1. Development and UAT Environment\n"
echo "2. PreProd and Production Environment\n"
echo "-------------------------------------------------------\n"


UsrEnv=$1
echo $UsrEnv
if [ -z "$UsrEnv" ];
then
    read UsrEnv
fi

if [ "$UsrEnv" -eq 1 ];
then
    export GREEN_BASE_URL="<NLB URL>:<PORT>"
    export BLUE_BASE_URL="<NLB URL>:<PORT>"
    export GREEN_VPC_LINK_ID="<VPCLinkID>"
    export BLUE_VPC_LINK_ID="<VPCLinkID>"
    export GREEN_STAGE_NAME="green"
    export BLUE_STAGE_NAME="blue"
    export FILE_NAME="sample-service.yaml"
    export AWS_PROFILE=dev
    export COGNITO_ID="arn:aws:cognito-idp:ap-south-1:<ACCOUNT_ID>:userpool/<REGION>_<COGNITO_ID>"
elif [ "$UsrEnv" -eq 2 ];
then
    export GREEN_BASE_URL="<NLB URL>:<PORT>"
    export BLUE_BASE_URL="<NLB URL>:<PORT>"
    export GREEN_STAGE_NAME="green"
    export BLUE_STAGE_NAME="blue"
    export GREEN_VPC_LINK_ID="<VPCLinkID>"
    export BLUE_VPC_LINK_ID="<VPCLinkID>"
    export FILE_NAME="sample-service.yaml"
    export AWS_PROFILE=prod
    export COGNITO_ID="arn:aws:cognito-idp:ap-south-1:<ACCOUNT_ID>:userpool/<REGION>_<COGNITO_ID>"
else
    echo  "Invalid option. Please enter either 1 or 2.\n"
fi

export STACK_NAME="sample-service"
export AWS_REGION="<REGION_ID>"

aws cloudformation deploy --profile $AWS_PROFILE \
--stack-name $STACK_NAME \
--template-file $FILE_NAME \
--region $AWS_REGION \
--parameter-overrides GreenBaseUrl=$GREEN_BASE_URL BlueBaseUrl=$BLUE_BASE_URL GreenStageName=$GREEN_STAGE_NAME BlueStageName=$BLUE_STAGE_NAME GreenVPCLinkId=$GREEN_VPC_LINK_ID BlueVPCLinkId=$BLUE_VPC_LINK_ID CognitoId=$COGNITO_ID 