pipeline{
    agent any
    environment {
        IMAGE_NAME = "deepaksag/spring-image"
    }
    stages{
        stage('checkout dockerfile'){
            steps{
                git branch:'main',url:'https://github.com/Coding4Deep/Docker-Spring-CI-CD-PROJECT.git'
            }
        }
          stage('Create Network') {
            steps {
                sh 'docker network create efk-net || true'
                sh 'docker network ls'
            }
        }
       stage('building image'){
           steps{
               sh 'docker build -t ${IMAGE_NAME} .'
               sh 'docker images'
           }
       }
       stage('Login to DockerHub & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME
                    '''
                }
            }
        }
       stage('run container'){
           steps{
               sh '''  
               docker stop springapp || true 
               docker rm -f springapp || true
               
               docker run --name springapp \
               --log-driver=fluentd \
               --log-opt fluentd-address=fluentd:24224 \
               --log-opt tag=springapp \
        
              --network efk-net \
              -p 8082:8080 \
              -d ${IMAGE_NAME}
               '''
           }
       }
        
        
    }
}
