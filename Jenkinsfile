pipeline {
    agent any

    environment {
        DOCKER_USERNAME = "ankitanallamilli"
        IMAGE_NAME = "healthy-hens"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'ankitagit',
                        url: 'https://github.com/2000ankitareddy/poultry-healthy-hens-java.git'
                    ]]
                )
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_USERNAME/$IMAGE_NAME:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'docker push $DOCKER_USERNAME/$IMAGE_NAME:latest'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f healthy-hens || true
                docker run -d -p 2000:8080 --name healthy-hens $DOCKER_USERNAME/$IMAGE_NAME:latest
                '''
            }
        }
    }
}
