pipeline {
    agent any

    stages {
        stage('sourcedoe') {
            steps {
                git branch: 'main', url: 'https://github.com/nilesh2121/terraformlab.git'
            } 
        }
        stage('terra init') {
            steps {
                sh 'teraform init'
            } 
        }
        stage('terra apply') {
            steps {
                sh 'terraform apply --auto-approve'
            } 
        }                  
    }
}    