#!/bin/bash

unset AZURE_SUBSCRIPTION_ID
unset ARM_SUBSCRIPTION_ID
unset ARM_CLIENT_ID
unset ARM_CLIENT_SECRET
unset AZURE_LOCATION

AZURE_SUBSCRIPTION_NAME="ea-cloudengineering-dev"
TERRAFORM_STATE_STORAGE_ACCOUNT="stcloudstatedev001"
TERRAFORM_STATE_CONTAINER_NAME="terraform-state"
TERRAFORM_MODULE_NAME="rg-ipamdev-dev-eus2-network"
ARM_RESOURCE_GROUP="rg-cloudengineering-dev-eus2-001"

az account set --subscription ${AZURE_SUBSCRIPTION_NAME}
terraform init -backend-config="storage_account_name=${TERRAFORM_STATE_STORAGE_ACCOUNT}" \
               -backend-config="container_name=${TERRAFORM_STATE_CONTAINER_NAME}" \
               -backend-config="key=${AZURE_SUBSCRIPTION_NAME}/ea-nonprod/${TERRAFORM_MODULE_NAME}/terraform.tfstate" \
               -backend-config="use_azuread_auth=false" \
               -backend-config="resource_group_name=${ARM_RESOURCE_GROUP}" \
               -backend=true \
               -get=true \
               -input=false
