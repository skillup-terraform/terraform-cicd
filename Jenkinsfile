pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/skillup-terraform/terraform-cicd']]])            

          }
        }
        
        stage ("terraform init") {
            steps {
                bat ('terraform init') 
            }
        }
        stage ("terraform validate") {
            steps {
                echo "Terraform action is --> validate"
                bat ('terraform validate') 
           }
        }
        stage ("terraform plan") {
            steps {
                echo "Terraform action is --> plan"
                bat ('terraform plan') 
           }
        }

        stage ("terraform apply") {
            steps {
                echo "Terraform action is --> apply"
                bat ('terraform destroy --auto-approve') 
           }
        }
    }
}
