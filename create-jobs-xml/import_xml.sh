#!/bin/bash

cd
WORK_SPACE=$(pwd)
cd ${WORK_SPACE}/jenkins-backup-code/pipeline_xml_backup

#Get the External IP Address of the VM instance.
VM_IP_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)

#Get the Jenkins Initial Password
JENKINS_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

#Need to Restart, to create jenkins jobs from .xml files. 
sudo systemctl restart jenkins

#Install required plugin.
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} install-plugin Generic-Webhook-Trigger -deploy

#Create Job from .xml file.
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job update_application < update_application.xml 
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job create_all_services < create_all_services.xml
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job create_kubernetes_cluster < create_kubernetes_cluster.xml 

#Create credentials from .xml files.
#Note: Change the credentails-password manually from the Jenkins console.
#java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} import-credentials-as-xml "system::system::jenkins" < git_cred.xml
