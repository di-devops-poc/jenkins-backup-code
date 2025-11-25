pipeline {
    agent any

    environment {
        BACKUP_DIR = '/var/backups/jenkins'
        JENKINS_HOME = '/var/lib/jenkins'
        TIMESTAMP = "${new Date().format('yyyyMMdd_HHmmss')}"
        BACKUP_FILE = "${BACKUP_DIR}/jenkins_backup_${TIMESTAMP}.tar.gz"
    }

    stages {
        stage('Quiet Down Jenkins') {
            steps {
                echo "Putting Jenkins in quiet mode (no new builds)..."
                sh "curl -X POST http://localhost:8080/quietDown"
            }
        }

        stage('Perform Backup') {
            steps {
                echo "Creating backup..."
                script {
					def status = sh(
                        echo "Creating Jenkins backup..."
						script: """
                            rsync -a --delete --exclude='workspace' --exclude='logs' ${JENKINS_HOME}/ ${BACKUP_DIR}/home_snapshot/
                            tar -czf '${BACKUP_FILE}' -C '${BACKUP_DIR}/home_snapshot' .
						""",
						returnStatus: true
					)
					if (status != 0) {
						echo "Warning: tar returned non-zero exit code ${status}, but backup file was likely created."
					}
					echo "Backup created at ${BACKUP_FILE}"
                }
            }
        }

        stage('Resume Jenkins Operations') {
            steps {
                sh "curl -X POST http://localhost:8080/cancelQuietDown"
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
            cleanWs()
        }
    }
}
