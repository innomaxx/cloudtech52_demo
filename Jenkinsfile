
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

    stages {
        stage('Infrastructure Init') {
            steps {
                dir('./terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Infrastructure Plan') {
            when {
                environment name: 'ACTION', value: 'plan';
            }
            steps {
                dir('./terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Infrastructure Apply') {
            when {
                environment name: 'ACTION', value: 'apply';
            }
            steps {
                dir('./terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Infrastructure Destroy') {
            when {
                environment name: 'ACTION', value: 'destroy';
            }
            steps {
                dir('./terraform') {
                   sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}