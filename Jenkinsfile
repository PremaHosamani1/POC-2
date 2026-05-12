pipeline {
    agent any
    
    tools {
        // Must match the names configured in Jenkins Global Tool Configuration
        maven 'Maven3' 
        jdk 'Java17'
    }

    stages {
        stage('Checkout') {
            steps {
                // Jenkins automatically checks out the code if using "Pipeline from SCM"
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Use 'bat' for Windows or 'sh' for Linux
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
    }
}
