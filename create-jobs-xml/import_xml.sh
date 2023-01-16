#!/bin/bash

cd
WORK_SPACE=$(pwd)
cd ${WORK_SPACE}/jenkins-backup-code/pipeline_xml_backup

#Get the External IP Address of the VM instance.
VM_IP_ADDRESS=$(gcloud compute instances describe my-ak-vm --zone='us-central1-a' --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

#Get VM Console Output in logs_output.txt
gcloud compute --project=di-devops-poc instances get-serial-port-output di-devops-vm --zone=us-central1-a --port=1 > logs_output.txt

#Get the Jenkins Initial Password
Pass_Line=$(cat logs_output.txt | grep "Please use the following password to proceed to installation:" -A1 | tail -n 1)
JENKINS_PASS=$(${Pass_Line##* })

#Need to Restart, to create jenkins jobs from .xml files. 
sudo systemctl restart jenkins

#Install required plugin.
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} install-plugin Generic-Webhook-Trigger -deploy

#Create Job from .xml file.
sed -e "s%cloudname%${1}%g" -e "s%filename%${2}%g" create_kubernetes_cluster.xml > temp.xml
mv temp.xml create_kubernetes_cluster.xml
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job create_kubernetes_cluster < create_kubernetes_cluster.xml

sed -e "s%cloudname%${1}%g" -e "s%filename%${2}%g" update_application.xml > temp.xml
mv temp.xml update_application.xml
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job update_application < update_application.xml 

sed -e "s%cloudname%${1}%g" -e "s%filename%${2}%g" create_all_services.xml > temp.xml
mv temp.xml create_all_services.xml
java -jar jenkins-cli.jar -s http://${VM_IP_ADDRESS}:8080/ -auth admin:${JENKINS_PASS} create-job create_all_services < create_all_services.xml
