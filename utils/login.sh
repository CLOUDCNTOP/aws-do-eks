#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

# source ./.env
source ~/.bashrc

# Docker image settings
## REGISTRY: [optional] - Docker registry path including trailing "/". Example: registry.company.com/demo/
## If REGISTRY==default, then the default elastic container registry in the account for the current region will be used 
export REGISTRY=default
## Set default registry if needed
if [ "$REGISTRY" == "default" ]; then
    export REGION=${AWS_REGION}
    export ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
    if [ "$ACCOUNT" == "" ]; then
	export REGISTRY=""
    else
    	export REGISTRY=${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/
    fi
fi
## Add trailing forward slash if needed
if [ -n "${REGISTRY}" ]; then
  if [ "${REGISTRY: -1}" != "/" ]; then
    export REGISTRY="${REGISTRY}/"
  fi
fi

# Login to container registry
echo "Logging in to ECR $REGISTRY ..."
aws ecr get-login-password | docker login --username AWS --password-stdin $REGISTRY
