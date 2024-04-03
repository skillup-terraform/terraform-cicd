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
                cmd ('terraform init') 
            }
        }
        stage ("terraform validate") {
            steps {
                echo "Terraform action is --> validate"
                cmd ('terraform validate') 
           }
        }
        stage ("terraform plan") {
            steps {
                echo "Terraform action is --> plan"
                cmd ('terraform plan') 
           }
        }

        stage ("terraform apply") {
            steps {
                echo "Terraform action is --> apply"
                cmd ('terraform destroy --auto-approve') 
           }
        }
    }
}
