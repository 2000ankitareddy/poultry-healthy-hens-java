pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'uday', url: 'https://github.com/Uday-63/poultry-healthy-hens-java.git']])
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t healthy-hens .'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p 2000:80 healthy-hens'
            }
        }

    }
}
