node('any') {
    stage('sourcedoe') {
        git branch: 'main', url: 'https://github.com/nilesh2121/terraformlab.git'
    }

    stage('terra init') {
        sh 'teraform init '
    }

    stage('terra apply') {
        sh 'terraform apply -auto-approve'
    }
}