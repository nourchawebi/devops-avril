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
                echo "Scanning Docker image with Trivy..."
                sh "trivy clean --java-db"
                sh "trivy image --timeout 20m --format table --scanners vuln --debug --ignore-unfixed -o trivy-imageesprit-report.html nourchawebi/astonvilla:1.1.${env.BUILD_NUMBER}"
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
   sh "docker image rm nourchawebi/astonvilla:1.1.${env.BUILD_NUMBER} || true"
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
