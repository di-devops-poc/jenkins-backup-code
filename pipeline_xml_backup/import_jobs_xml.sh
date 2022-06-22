cd jenkins-backup-code/pipeline_xml_backup

java -jar jenkins-cli.jar -s http://34.123.83.8:8080/ -auth admin:21d1db515ba343ca859d53158063f6dd create-job update_application < update_application.xml 

java -jar jenkins-cli.jar -s http://34.123.83.8:8080/ -auth admin:21d1db515ba343ca859d53158063f6dd create-job create_all_services < create_all_services.xml

java -jar jenkins-cli.jar -s http://34.123.83.8:8080/ -auth admin:21d1db515ba343ca859d53158063f6dd create-job create_kubernetes_cluster < create_kubernetes_cluster.xml 

java -jar jenkins-cli.jar -s http://34.123.83.8:8080/ -auth admin:21d1db515ba343ca859d53158063f6dd import-credentials-as-xml "system::system::jenkins" < git_cred.xml
