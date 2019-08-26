def remote = [:]
    remote.name = 'test'
    remote.host = 'rjzfg18876dns1.eastus2.cloudapp.azure.com'
    remote.user = 'devopsinfra'
    remote.password = 'Applestore12$4'
    remote.allowAnyHosts = true

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
        //         sh "sudo cp $WORKSPACE/target/*.jar $WORKSPACE/spring-petclinic.jar"
        //         sh "sudo docker build --build-arg JAR_FILE_PATH=./spring-petclinic.jar -t nir16r/spring-petclinic:$VERSION ."
        //         sh "sudo docker push nir16r/spring-petclinic:$VERSION"
        //         sh "sudo rm -r $WORKSPACE/spring-petclinic.jar"
        //         sh "sudo docker rmi -f nir16r/spring-petclinic:$VERSION"
        //     }
        // }
        stage('Transfer ansible playbook') {
            steps{
                writeFile file: 'spring-pet-playbook.yaml', text: 'ls -lrt'
                sshPut remote: remote, from: 'spring-pet-playbook.yaml', into: '.'
                // sshCommand remote: remote, command: "ls -lrt"
                // sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
            }
        }
    }
}
