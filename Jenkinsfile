pipeline {
agent any

```
environment {
    AWS_REGION = 'us-east-1'
    ACCOUNT_ID = '040162742712'
    REPO_NAME = 'java-demo-app'

    IMAGE_URI = "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}"
}

stages {

    stage('Checkout') {
        steps {
            checkout scm
        }
    }

    stage('Build Maven Project') {
        steps {
            sh 'mvn clean package'
        }
    }

    stage('Login to ECR') {
        steps {
            sh '''
            aws ecr get-login-password --region ${AWS_REGION} \
            | docker login --username AWS \
            --password-stdin \
            ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
            '''
        }
    }

    stage('Build Docker Image') {
        steps {
            sh '''
            docker build \
            -t ${IMAGE_URI}:${BUILD_NUMBER} \
            -t ${IMAGE_URI}:latest .
            '''
        }
    }

    stage('Push Docker Image') {
        steps {
            sh '''
            docker push ${IMAGE_URI}:${BUILD_NUMBER}
            docker push ${IMAGE_URI}:latest
            '''
        }
    }

    stage('Deploy Container') {
        steps {
            sh '''
            docker rm -f java-app || true

            docker run -d \
            --name java-app \
            --restart always \
            -p 8081:8080 \
            ${IMAGE_URI}:${BUILD_NUMBER}
            '''
        }
    }
}
```

}
