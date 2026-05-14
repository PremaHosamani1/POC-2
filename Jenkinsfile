pipeline {
    agent any

    environment {
        IMAGE_NAME = "poc"
        CONTAINER_NAME = "poc-container"
        PORT = "8081"
    }

    stages {

        stage('Checkout') {
            steps {
                deleteDir()
                git branch: 'main', url: 'https://github.com/PremaHosamani1/POC-2.git'
            }
        }

        stage('Verify Code') {
            steps {
                sh 'grep -i "POC" src/main/java/com/example/demo/DemoApplication.java'
            }
        }
        stage('DEBUG: Show Code') {
            steps {
                sh '''
                echo "==== FILE CONTENT ===="
                cat src/main/java/com/example/demo/DemoApplication.java
                '''
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
