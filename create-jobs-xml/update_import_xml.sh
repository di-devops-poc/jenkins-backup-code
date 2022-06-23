#!/bin/bash
WORK_SPACE=$(pwd)
cd ${WORK_SPACE}/jenkins-backup-code/create-jobs-xml


VM_IP_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)

JENKINS_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)


sed -e 's%VM_IP_ADDR%'"${VM_IP_ADDRESS}"'%g' -e 's%PASS%'"${JENKINS_PASS}"'%g' import_xml.sh > temp.sh
mv temp.sh import_xml.sh

bash -x import_xml.sh
