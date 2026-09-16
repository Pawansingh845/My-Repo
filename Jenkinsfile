pipeline{
    agent any 
    stages {
        stage ('gitcheckout') {
            steps {
                git branch : 'main',
                  url: 'https://github.com/Pawansingh845/My-Repo'

    }
 }
  
        stage ('doker build') {
           steps {
             sh 'docker build -t newtech:v1 .'
    }

 }
    
        stage ('images check ') {
            steps {
              sh 'docker images'
    }
 }

    
        stage ('docker run') {
            steps {
              sh 'docker run -d --name newtech -p 8085:80 newtech:v1'
        }
    } 
         
        stage ('verfy') {
          steps { 
            sh 'docker ps '
        }
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