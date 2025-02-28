pipeline {
    agent any

    stages {
        stage('Pull') {
            steps {
                // Git branch adını doğru girin: 'main' veya 'master'
                git branch: 'main', url: 'https://github.com/CerenT07/WebApiTest.git'
            }
        }

       
    
        stage('Build') {
            steps {
                bat 'dotnet build "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\WebApiProject" --configuration Release'
            }
        }
         stage('Testing'){
            steps{
                bat 'dotnet test  "C:\\Users\\HP\\Desktop\\WebApiTest\\WebApiTest.csproj"'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t wepapi:dev .'
            }
        }

        stage('Docker Run') {
            steps {
                bat 'docker run -d --name my-containersu-name wepapi:dev'
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
