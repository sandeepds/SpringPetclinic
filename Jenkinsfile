pipeline{
    agent any
    stages{
        stage('Git - Checkout') {
            steps{
                git branch: 'master', credentialsId: '', url: 'https://github.com/NirakhRastogi/SpringPetclinic.git'
            }
       }
       stage('Build') {
            steps{
                withMaven(maven:'Maven'){
                    sh "mvn install"
                }
            }
        }
        stage('SonarQube analysis') {
            steps{
                withSonarQubeEnv('Sonar') {
                    withMaven(maven:'Maven'){
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage('Build and Push Spring Petclinic Docker Image') {
            steps{
                sh "sudo cp $WORKSPACE/target/*.jar $WORKSPACE/spring-petclinic.jar"
                sh "sudo docker build --build-arg JAR_FILE_PATH=./spring-petclinic.jar -t nir16r/spring-petclinic:$VERSION ."
                sh "sudo docker push nir16r/spring-petclinic:$VERSION"
                sh "sudo rm -r $WORKSPACE/spring-petclinic.jar"
                sh "sudo docker rmi -f nir16r/spring-petclinic:$VERSION"
            }
        }
    }
}
