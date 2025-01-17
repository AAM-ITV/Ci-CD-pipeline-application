pipeline {
    agent any

    stages {
        stage('Build and Push Application') {
            steps {
                script {
                    docker.image('docker:27.4.0').inside('--user root -v /var/run/docker.sock:/var/run/docker.sock') {
                        sh """   
                            docker login -u aamitv -p dckr_pat_6cNg7aFWXXGcJ8YpWouSf0kgxfs https://index.docker.io/v1/  
                          //  cd /var/lib/jenkins/workspace/deploy-app
                            docker build -f /var/lib/jenkins/workspace/deploy-app/Dockerfile -t aamitv/app-ci-cd .
                            docker push aamitv/app-ci-cd
                        """
                    }
                }
            }
        }
    }
}


//        stage('Run instance on yandex-cloud') {
         
//          steps {
//             sh 'terraform init'
//             sh 'terraform apply -auto-approve'
//          }
//     }

//        stage('Generate Ansible Inventory') {
//          steps {
//             script {
//                 def prodNodeIp = sh(script: 'terraform output -raw prod_stand_ip', returnStdout: true).trim() // Get production node IP

//                 writeFile file: 'hosts', text: """
//                        [prod-stand]
//                        ${prodNodeIp} ansible_user=jenkins ansible_ssh_private_key_file=${SSH_KEY_PATH} ansible_ssh_common_args='-o StrictHostKeyChecking=no'
//                     """ // Create Ansible inventory file
//                 }
//             }
//         }
       
 
//        stage('Deploy app') {
//         steps {
//             script {
//                 sh 'ansible-playbook -i hosts prod-stand.yml --private-key=${SSH_KEY_PATH}' // Run playbook on prod-stand'
//                 }
//             }
//         }
//     }
// }
//  #######################################################################################################   


   
// }
//    agent {
//         docker {
//            image 'docker:27.4.0'
//            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'  #running  container with root privileges for docker
//         }
