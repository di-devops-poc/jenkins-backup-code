#!/bin/bash
cd
WORK_SPACE=$(pwd)
cd ${WORK_SPACE}/jenkins-backup-code/pipeline_xml_backup

VM_IP_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)

JENKINS_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job update_application < update_application.xml 

java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job create_all_services < create_all_services.xml

java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job create_kubernetes_cluster < create_kubernetes_cluster.xml 

java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} import-credentials-as-xml "system::system::jenkins" < git_cred.xml
