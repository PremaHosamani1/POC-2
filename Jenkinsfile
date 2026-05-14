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
                git branch: 'main', url: 'https://github.com/PremaHosamani1/POC-2.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Building fresh image with unique tag..."
                docker build --no-cache -t $IMAGE_NAME:$BUILD_NUMBER .
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                echo "Stopping old container..."
                docker rm -f $CONTAINER_NAME || true

                echo "Running new container with latest image..."
                docker run -d -p $PORT:8080 --name $CONTAINER_NAME $IMAGE_NAME:$BUILD_NUMBER
                '''
            }
        }

        stage('Cleanup Old Images') {
            steps {
                sh '''
                echo "Cleaning unused images..."
                docker image prune -f
                '''
            }
        }
    }
}
