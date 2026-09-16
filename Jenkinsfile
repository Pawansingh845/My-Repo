pipeline{
    agentany 
    stages {
        stage ('gitcheckout') {
          git 'https://github.com/Pawansingh845/My-Repo'

    }
 }
    stages {
        stage ('doker build') {
        sh 'docker build -t newtech:v1'
    }

 }
    stages {
        stages ('images check ') {
        sh 'docker images'
    }
 }

    stages {
        stage ('docker run') {
        sh 'doker run -d --name newtech -p 8085:80 newtech:v1'
        }
    } 
    stages {
        stage ('verfy') {
        sh 'docker ps '
        }
    }
post {
    success {
        echo 'my deployement done '
    }
    failure {
        echo 'deployement fail'
    }

}

}