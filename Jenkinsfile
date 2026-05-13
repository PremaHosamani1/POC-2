pipeline {
    agent any

    environment {
        AWS_ACCOUNT = "040162742712"
        REGION = "us-east-1"
        IMAGE_NAME = "poc"
        ECR_REPO = "${AWS_ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/poc:latest"
    }

    stages {

        stage('Clone Code') {
            steps {
                git 'https://github.com/YOUR_USERNAME/poc-demo.git'
            }
        }

        stage('Check AWS Identity') {
           steps {
              sh 'aws sts get-caller-identity'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t poc .'
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $REGION | \
                docker login --username AWS --password-stdin \
                $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com
                '''
            }
        }

        stage('Tag Image') {
            steps {
                sh 'docker tag poc:latest $ECR_REPO'
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'docker push $ECR_REPO'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop poc-container || true
                docker rm poc-container || true
                docker run -d -p 8081:8081 --name poc-container $ECR_REPO
                '''
            }
        }
    }
}
