# jenkins-backup-code

This is the third part of the application. import_xml.sh file will create all the jobs and install the required plugins on Jenkins.
Steps:
1. SSH into the Virtual Machine.
2. Clone this repository. `git clone https://github.com/di-devops-poc/jenkins-backup-code.git`
3. `cd gcp-devops-code/create-jobs-xml`
4. Execute the import_xml.sh script. `bash -x import_xml.sh`.
5. Open the Jenkins console.
6. Create the Github Credentails from `Manage Credentials`. Set `credentialsId` as `git_credentials`
7. You are good to go. You can start buiding Jobs.
