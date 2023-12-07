pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nilesh2121/terraformlab.git'
            } 
        }
        stage('teraform init') {
            steps {
                sh 'teraform init'
            } 
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            } 
        }                  
    }
}    