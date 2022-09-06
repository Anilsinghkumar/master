pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
    stages{
        stage('git checkout'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '9a45c966-7b10-4fc4-a328-5a26f8411b77', url: 'https://github.com/Anilsinghkumar/master']]])
            }
        }
        stage('Terraform init'){
            steps{
                sh ("terraform init");
            }
        }
        stage('Terraform Validate'){
            steps{
                sh ("terraform validate");
            }
        }
    }
}  
