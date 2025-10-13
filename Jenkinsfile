pipeline {
    agent any

    environment {
        BACKUP_DIR = '/var/backups/jenkins'
        JENKINS_HOME = '/var/lib/jenkins'
        TIMESTAMP = "${new Date().format('yyyyMMdd_HHmmss')}"
        BACKUP_FILE = "${BACKUP_DIR}/jenkins_backup.tar.gz"
    }

    stages {
        stage('Enable Quiet Mode') {
            steps {
                script {
                    // Puts Jenkins into quiet mode
                    def jenkins = Jenkins.instance
                    jenkins.doQuietDown()
                    echo "Jenkins is in quiet mode."
                    echo "Creating backup..."
                    sh """
                        tar -czf ${BACKUP_FILE} ${JENKINS_HOME}
                        echo "Backup created at ${BACKUP_FILE}"
                    """
                }
            }
        }

        stage('Upload to GCS') {
            steps {
                sh "gsutil cp ${BACKUP_FILE} gs://devops-jenkins-bkp/"
            }
        }

        stage('Disable Quiet Mode') {
            steps {
                script {
                    Jenkins.instance.doCancelQuietDown()
                    echo "Jenkins resumed normal operation."
                }
            }
        }
    }

    post {
        always {
            echo "Backup pipeline completed."
        }
    }
}
