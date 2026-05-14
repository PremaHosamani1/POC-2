pipeline {
    agent any

    environment {
        APP_NAME = "poc"
        CONTAINER_NAME = "poc-container"
        PORT = "8081"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/PremaHosamani1/POC-2.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh '''
                echo "Building application..."
                mvn clean package -DskipTests
                '''
            }
        }

        stage('Verify Build') {
            steps {
                sh '''
                echo "Checking JAR file..."
                ls -l target
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Removing old image..."
                docker rmi $APP_NAME || true

                echo "Building new Docker image..."
                docker build --no-cache -t $APP_NAME .
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                echo "Stopping old container..."
                docker rm -f $CONTAINER_NAME || true

                echo "Running new container..."
                docker run -d -p $PORT:8080 --name $CONTAINER_NAME $APP_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                echo "Running containers:"
                docker ps

                echo "Testing application:"
                curl -I http://localhost:$PORT || true
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Access app at http://<JENKINS-IP>:8081"
        }
        failure {
            echo "❌ Build failed. Check logs."
        }
    }
}
