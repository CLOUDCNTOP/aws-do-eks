#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

# Ref: https://docs.aws.amazon.com/eks/latest/userguide/retrieve-ami-id.htm

source ./nodegroup.conf

echo ""
echo "Listing AMI ..."
echo ""
CMD="aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.28/amazon-linux-2-gpu/recommended/image_id --region $REGION --query 'Parameter.Value' --output text"
echo "$CMD"
eval "$CMD"

