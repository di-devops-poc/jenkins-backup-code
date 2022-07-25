# jenkins-backup-code

•	It contains Jenkins server backup in xml files and code in import_xml.sh file.
•	Script import_xml.sh reads Jenkins backup xml files and imports them to Jenkins server. Then jobs are visible on Jenkins interface.
•	This shell script import_xml.sh also installs the required plugins on Jenkins server.

Steps yo use:
1. SSH into the Virtual Machine.
2. Clone this repository. `git clone https://github.com/di-devops-poc/jenkins-backup-code.git`
3. `cd gcp-devops-code/create-jobs-xml`
4. Execute the import_xml.sh script. `bash -x import_xml.sh`.
5. Open the Jenkins console.
6. Create the Github Credentails from `Manage Credentials`. Set `credentialsId` as `git_credentials`
7. You are good to go. You can start buiding Jobs.


-------------------------------------------------------------------------------------------------------------------------

For more details on the Jenkins Job Check [here](https://github.com/di-devops-poc/jenkins-backup-code/tree/main/create-jobs-xml).
