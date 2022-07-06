
pipeline {
    agent any

    tools {
        terraform 'terraform'
    }

    parameters {
        choice(
            choices: ['plan', 'apply', 'destroy'],
            description: 'Run plan / apply / destroy',
            name: 'ACTION'
        )
    }

    environment {
        withCredentials([string(credentialsId: 'aws_eip_alloc_id', variable: 'AWS_EIP_ALLOC_ID')]) {
            TF_VAR_aws_eip_alloc_id = $AWS_EIP_ALLOC_ID
        }
    }

    stages {
        stage('Infrastructure Init') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-central-1') {
                    dir('./terraform') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Infrastructure Plan') {
            when {
                environment name: 'ACTION', value: 'plan';
            }
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-central-1') {
                    dir('./terraform') {
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Infrastructure Apply') {
            when {
                environment name: 'ACTION', value: 'apply';
            }
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-central-1') {
                    dir('./terraform') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Infrastructure Destroy') {
            when {
                environment name: 'ACTION', value: 'destroy';
            }
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-central-1') {
                    dir('./terraform') {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}