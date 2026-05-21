pipeline {
    agent any

    environment {
        IMAGE_NAME = "poc"
        CONTAINER_NAME = "poc-container"
        PORT = "8081"
    }

    tools {
        maven 'Maven'
    }

    stages {

        stage('Checkout') {
            steps {
                deleteDir()
                git branch: 'main', url: 'https://github.com/PremaHosamani1/POC-2.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=poc-project \
                    -Dsonar.projectName="POC Project" 
                    '''
                }
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker rm -f poc-container || true
                docker build --no-cache -t poc .
                docker run -d -p 8081:8080 --name poc-container poc
                '''
            }
        }
    }
}
