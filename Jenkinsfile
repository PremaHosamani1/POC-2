node('amazon-linux-node') {

    def AWS_ACCOUNT = "040162742712"
    def REGION = "us-east-1"
    def ECR_REPO = "${AWS_ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/poc:latest"

    stage('Checkout') {
        checkout scm
    }

    stage('Build (Maven Package)') {
        def mvn = tool 'Maven'
        sh "${mvn}/bin/mvn clean package"

        // 🔍 IMPORTANT: verify jar exists
        sh "ls -l target/"
    }



    stage('Debug Jar') {
    sh 'ls -l target/'
    sh 'find . -name "*.jar"'
}

    stage('Docker Build') {
        sh """
        set -e

        echo "Checking jar..."
        ls -l target/

        echo "Building Docker image..."
        docker build -t poc:latest .
        """
    }

    stage('Docker Push to ECR') {
        sh """
        aws ecr get-login-password --region ${REGION} | \
        docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com

        docker tag poc:latest ${ECR_REPO}
        docker push ${ECR_REPO}
        """
    }

    stage('Deploy') {
        sh """
        set -e

        docker rm -f poc || true

        docker pull ${ECR_REPO}

        docker run -d -p 8081:8080 --name poc ${ECR_REPO}
        """
    }
}
