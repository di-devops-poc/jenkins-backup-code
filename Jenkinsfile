pipeline {
    agent any
    stages {
        stage('Enable Quiet Mode') {
            steps {
                script {
                    def jenkins = Jenkins.getInstance()
                    jenkins.doQuietDown()
                    echo "Quiet mode enabled."
                }
            }
        }
    }
}
