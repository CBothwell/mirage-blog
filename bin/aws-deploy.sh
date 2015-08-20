#!/usr/bin/env bash
rsync -avP $PWD/mir-seal.xen ec2-user@${EC2_BUILD_HOST}:/home/ec2-user/
ssh -t ec2-user@${EC2_BUILD_HOST} "bash bin/aws-deploy.sh -k mir-seal.xen"
