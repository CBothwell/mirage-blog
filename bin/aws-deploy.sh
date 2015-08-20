#!/usr/bin/env bash
rsync -avP $PWD/mir-seal.xen ec2-user@${EC2_BUILD_HOST}:/home/ec2-user/
ssh -t ec2-user@${EC2_BUILD_HOST} "bash bin/aws-deploy.sh -k mir-seal.xen"
(ssh -t ec2-user@${EC2_BUILD_HOST} "cat register") > deploy
id=$(eval $(cat deploy) |awk '{print $2}')
ec2-run-instances --region us-west-2 $id
