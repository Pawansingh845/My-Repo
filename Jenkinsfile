pipeline{
    agent any 
    parameters {
        string(
            name: 'IMAGE_TAG',
            defaultValue: 'v1',
            description: 'Docker image tag'
        )
    }
    environment {
        IMAGE_NAME = 'newtech'
        IMAGE_TAG  = 'v1'
        CONTAINER_NAME = 'newtech'
        HOST_PORT = '8085'
    }



    stages {
        stage ('gitcheckout') {
            steps {
                git branch : 'main',
                  url: 'https://github.com/Pawansingh845/My-Repo'

    }
 }
        stage('sonar scan') {
            steps {
                withSonarQubeEnv('Sonar') {
            sh '''
                sonar-scanner \
                -Dsonar.projectKey=newtech \
                -Dsonar.sources=.
            '''
                }
            }
        }
           
  
        stage ('doker build') {
           steps {
             sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
    }

 }
    
        stage ('images check ') {
            steps {
              sh 'docker images'
    }
 }

    
        stage ('docker run') {
            steps {
              sh 'docker run -d --name ${IMAGE_TAG} -p ${HOST_PORT}:80 ${IMAGE_NAME}:${IMAGE_TAG}'
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