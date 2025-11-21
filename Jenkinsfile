pipeline {
    agent any

    environment {
        BACKUP_DIR = '/var/backups/jenkins'
        JENKINS_HOME = '/var/lib/jenkins'
        TIMESTAMP = "${new Date().format('yyyyMMdd_HHmmss')}"
        BACKUP_FILE = "${BACKUP_DIR}/jenkins_backup_${TIMESTAMP}.tar.gz"
    }

    stages {
        stage('Backup Jenkins Home') {
            steps {
                echo "Creating backup..."
                script {
                    sh """
                        tar --warning=no-file-changed --exclude="logs" -czf "${BACKUP_FILE}" -C "${JENKINS_HOME}" .
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
    }

    post {
        always {
            echo "Backup pipeline completed."
        }
    }
}
