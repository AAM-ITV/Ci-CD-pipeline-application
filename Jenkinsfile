pipeline {
    agent {
        docker {
           image 'docker:27.4.0'
           args '--user root -v /var/run/docker.sock:/var/run/docker.sock'  #running  container with root privileges for docker
        }
    }
    stages {
        stage ('git clone repo') {
         steps {
            git 'https://github.com/AAM-ITV/demo18.git'   
          }    
        }
       stage('Build and Push Application') {
         steps {
            sh """                                   
        docker login -u yourlogin -p yourpasswd https://index.docker.io/v1/    
        docker build -t aamitv/app-jenkins .
        docker push aamitv/app-jenkins
        """
    }
}
    
       stage('Deploy Application') {
        steps {
            script {
            def remote = [:]
            remote.name = 'prod-node'
            remote.host = '192.168.0.3'
            remote.user = 'root'
            remote.password = 'qwe123'
            remote.allowAnyHosts = true

            sshCommand remote: remote, command: """
                docker pull aamitv/app-jenkins:latest
                docker run -d -p 8080:8080 --name app-demo18 aamitv/app-jenkins:latest
            """
            }
         }
      }

    }
}
