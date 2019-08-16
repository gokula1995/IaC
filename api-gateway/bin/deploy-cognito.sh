#!/bin/sh
# create Resource Snippet ONE
AWS_REGION=ap-south-1

echo "Please select the environment:\n"
echo "-------------------------------------------------------\n"
echo '1. Development (Default)\n'
echo '2. Production\n'
echo "-------------------------------------------------------\n"
read USER_OPT

if [[ $USER_OPT = 1 ]];
then
    USER_POOL_ID=<REGION>_<COGNITO_ID>
    AWS_PROFILE=dev
elif [[ $USER_OPT = 2 ]];
then
    USER_POOL_ID=<REGION>_<COGNITO_ID>
    AWS_PROFILE=prod
fi



aws cognito-idp \
create-resource-server  \
--user-pool-id  $USER_POOL_ID \
--identifier blackboxservice   \
--name BlackboxService   \
--scopes  '[
    {
        "ScopeDescription": "read sample service details.",
        "ScopeName": "sample.read"
    }
]' \
--profile $AWS_PROFILE \
--region $AWS_REGION