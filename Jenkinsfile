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
        // stage('Build and Push Spring Petclinic Docker Image') {
        //     steps{
        //         sh "sudo cp $WORKSPACE/cape-registry/target/*.jar $WORKSPACE/dockerfiles/service.jar"
        //         sh "sudo docker build --build-arg JAR_FILE_PATH=./dockerfiles/service.jar --build-arg COMMON_PROPERTIES_PATH=./dockerfiles/common.properties -f $WORKSPACE/dockerfiles/Registry.Dockerfile -t cape-demo-registry.southeastasia.cloudapp.azure.com/cape-registry:$VERSION ."
        //         sh "sudo docker push cape-demo-registry.southeastasia.cloudapp.azure.com/cape-registry:$VERSION"
        //         sh "sudo rm -r $WORKSPACE/dockerfiles/service.jar"
        //         sh "sudo docker rmi -f cape-demo-registry.southeastasia.cloudapp.azure.com/cape-registry:$VERSION"
        //     }
        // }
    }
}
