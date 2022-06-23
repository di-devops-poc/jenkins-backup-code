cd jenkins-backup-code/pipeline_xml_backup

java -jar jenkins-cli.jar -s VM_IP_ADDR -auth admin:PASS create-job update_application < update_application.xml 

java -jar jenkins-cli.jar -s VM_IP_ADDR -auth admin:PASS create-job create_all_services < create_all_services.xml

java -jar jenkins-cli.jar -s VM_IP_ADDR -auth admin:PASS create-job create_kubernetes_cluster < create_kubernetes_cluster.xml 

java -jar jenkins-cli.jar -s VM_IP_ADDR -auth admin:PASS import-credentials-as-xml "system::system::jenkins" < git_cred.xml
