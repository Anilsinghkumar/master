pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
    stages{
        stage('git checkout'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '7943480f-08e4-47be-9ab7-5db422a6dffc', url: 'https://bitbucket.org/anilksin/scp-tf-module-vpc']]])
            }
        }
        stage('Terraform Init'){
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
