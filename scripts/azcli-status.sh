#!/bin/bash

ACCOUNT_INFO=$(az account show 2> /dev/null)
if [[ $? -ne 0 ]]; then
    exit
fi

SUB_NAME=$(echo $ACCOUNT_INFO | jq -r .name)

STATUS_LINE="$SUB_NAME"

echo "$STATUS_LINE"

# SUB_ID=$(echo "$ACCOUNT_INFO" | jq ".id" -r)
# SUB_NAME=$(echo "$ACCOUNT_INFO" | jq ".name" -r)
# USER_NAME=$(echo "$ACCOUNT_INFO" | jq ".user.name" -r)

# STATUS_LINE="$USER_NAME @"

# if [[ "$SUB_ID" == "MY_PERSONAL_SUBSCRIPTION_ID" ]]; then
#     STATUS_LINE="$STATUS_LINE 🏠"
# elif [[ "$SUB_ID" == "MY_WORK_SUBSCRIPTION_ID" ]]; then
#     STATUS_LINE="$STATUS_LINE 🏢"
# else
#     STATUS_LINE="$STATUS_LINE $SUB_NAME"
# fi

# echo "$STATUS_LINE"