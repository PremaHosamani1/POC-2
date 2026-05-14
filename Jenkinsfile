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

        stage('Deploy Fresh Container') {
            steps {
                sh '''
                echo "Stopping old container..."
                docker rm -f $CONTAINER_NAME || true

                echo "Removing old image..."
                docker rmi $IMAGE_NAME || true

                echo "Building new image..."
                docker build --no-cache -t $IMAGE_NAME .

                echo "Running new container..."
                docker run -d -p $PORT:8080 --name $CONTAINER_NAME $IMAGE_NAME

                echo "Waiting for app to start..."
                sleep 10

                echo "Testing app..."
                curl http://localhost:$PORT || true
                '''
            }
        }
    }
}
