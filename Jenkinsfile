pipeline{

environment{
DOCKERHUB_CREDENTIALS = credentials('dockerhub')
}
agent any

stages{
stage("clean up ")
{
steps{
deleteDir()}}
  stage("checkout"){
  steps{
  git url :'https://github.com/nourchawebi/devops-avril.git' , branch : 'master'
  }
  }
  stage("generate docker image")
  {
  steps
  {
  sh "docker build -t nourchawebi/astonvilla:1.1.${env.BUILD_NUMBER}  . "
  }
  }
    stage('OWASP SCAN') {
      steps {
          dependencyCheck additionalArguments: '', odcInstallation: 'DP-CHECK'
          dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
      }
  }
  stage('Docker Image Scan') {
              steps {
                  sh "trivy image --format table -o trivy-image-report.html nourchawebi/astonvilla-app:1.1.${env.BUILD_NUMBER} "
              }
          }

  stage("login")
  {
  steps{
  sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin "
  }}
stage("push")
{
steps{
sh "docker push nourchawebi/astonvilla:1.1.${env.BUILD_NUMBER}"
}
}


}
}
// pipeline {
//     agent any
//     stages {
//         stage('Greetingg') {
//             steps {
//                 sh 'echo "Hello we are creating a pipeline for astonvilla App!"'
//             }
//         }
//     }
// }
