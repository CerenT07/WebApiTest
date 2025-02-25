pipeline{
   
    agent any 
  
    stages('Checkout'){
        
        stage('pull'){

            scripts{

               git 'https://github.com/CerenT07/WebApiTest.git'

            }

        }

        stage('Restore dependices'){
            steps{
                scripts{
                    bat 'dotnet restore WepApi/WepApi.csproj'
                }

            }
            stage('build'){

                steps{

                    bat 'dotnet restore WepApi/WepApi.csproj --configuration Release'
                   
                }

            }
            stage('docker build'){

                steps{
                    scripts{

                        bat 'docker build -t wepapi:dev C:/Users/HP/source/repos/WepApi/WepApi '

                    }
                }
            }

            stage('docker run'){
                steps{
                    scripts{
                        
                        bat 'docker run -d --name my-container-name wepapi:dev'
                    }
                }
            }

        }
         
    }
    post{

        success{

            echo 'This pipeline is working successfully !'
        }


        failure{

            echo 'This pipeline is not working true!'
            
        }
    }
}
