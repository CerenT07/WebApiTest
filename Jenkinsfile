pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Git branch adını doğru girin: 'main' veya 'master'
                git branch: 'main', url: 'https://github.com/CerenT07/WebApiTest.git'
            }
        }

        stage('Restore Dependencies') {
            steps {
                bat 'dotnet restore WepApi.csproj'
            }
        }

        stage('Build') {
            steps {
                bat 'dotnet build WepApi.csproj --configuration Release'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t wepapi:dev docker build -t wepapi:dev C:/Users/HP/source/repos/WepApi/
'
            }
        }

        stage('Docker Run') {
            steps {
                bat 'docker run -d --name my-container-name wepapi:dev'
            }
        }
    }

    post {
        success {
            echo 'This pipeline is working successfully!'
        }

        failure {
            echo 'This pipeline is not working correctly!'
        }
    }
}
