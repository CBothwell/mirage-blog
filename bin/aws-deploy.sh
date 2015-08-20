#!/usr/bin/env bash
rsync -avP $PWD/mir-seal.xen ec2-user@${EC2_BUILD_HOST}:/home/ec2-user/
