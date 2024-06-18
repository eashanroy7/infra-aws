pipeline {
    agent any
    stages {
        stage('Checkout') {
          steps{
            git(url: 'https://github.com/csye7125-su24-team17/infra-aws.git', branch: 'main', credentialsId: 'github-pat')
          }
        }
        stage('Helm lint and template') {
          when {
            expression { env.CHANGE_ID != null }
          }
          steps{
            sh '''
            terraform init
            terraform fmt -check
            terraform validate -no-color
            '''
          }
        }
    }
}