These .xml files are used to create the respective Jenkins jobs. The import_xml.sh script will create all the Jobs using Jenkins CLI.

1. `create_kubernetes_cluster.xml`:  This file will create `create_kubernetes_cluster` job. This Jobs should be build only for the first time to create cluster on which application going to be deployed.
2. `create_all_services.xml` : This file will create `create_all_services` job. This job will be trigerred automatically after create_kubernetes_cluster job. This job will deploy all the application services on the cluster.
3. `update_application.xml`: This file will create `update_application job`. This job will be triggered automatically, if there are any updates in the application. All the updates in the application will be reflected with the help of this job.a
