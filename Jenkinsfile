pipeline {
    agent any

    stages {
        stage('ST1 Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/skillup-terraform/terraform-cicd']]])            

          }
        }
        
        stage ("ST2 terraform init") {
            steps {
                sh ('terraform init') 
            }
        }
        stage ("terraform validate") {
            steps {
                echo "Terraform action is --> validate"
                sh ('terraform validate') 
           }
        }
        stage ("terraform plan") {
            steps {
                echo "Terraform action is --> plan"
                sh ('terraform plan') 
           }
        }

        stage ("terraform apply") {
            steps {
                echo "Terraform action is --> apply"
                sh ('terraform apply --auto-approve') 
           }
        }
    }
}