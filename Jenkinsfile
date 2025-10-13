pipeline {
    agent { label 'master' }  // Or any agent where Jenkins is installed

    environment {
        BACKUP_DIR = '/var/backups/jenkins'
        JENKINS_HOME = '/var/lib/jenkins'
        TIMESTAMP = "${new Date().format('yyyyMMdd_HHmmss')}"
        BACKUP_FILE = "${BACKUP_DIR}/jenkins_backup_${env.TIMESTAMP}.tar.gz"
    }

    stages {
        stage('Prepare') {
            steps {
                script {
                    // Ensure backup directory exists
                    sh "mkdir -p ${BACKUP_DIR}"
                }
            }
        }

        stage('Enable Quiet Mode') {
            steps {
                script {
                    // Puts Jenkins into quiet mode
                    def jenkins = Jenkins.instance
                    jenkins.doQuietDown()
                    echo "Jenkins is in quiet mode. Waiting for running jobs to finish..."
                }
            }
        }

        stage('Wait for Running Jobs') {
            steps {
                script {
                    // Wait for running builds to finish (max 5 min)
                    int waitSecs = 0
                    while (Jenkins.instance.computers.any { c -> c.executors.any { e -> e.isBusy() } }) {
                        if (waitSecs > 300) {
                            error("Timeout waiting for builds to finish.")
                        }
                        sleep(time: 5, unit: 'SECONDS')
                        waitSecs += 5
                    }
                }
            }
        }

        stage('Backup Jenkins Home') {
            steps {
                echo "Creating backup..."
                script {
                    sh """
                        tar -czf ${BACKUP_FILE} ${JENKINS_HOME}
                        echo "Backup created at ${BACKUP_FILE}"
                    """
                }
            }
        }

        // Optional: upload to Cloud Storage, S3, etc.
        // stage('Upload to GCS') {
        //     steps {
        //         sh "gsutil cp ${BACKUP_FILE} gs://your-bucket-name/jenkins/"
        //     }
        // }

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
