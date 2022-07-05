
pipeline {
    agent any

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
                sh 'terraform init'
            }
        }

        stage('Infrastructure Plan') {
            when {
                environment name: 'ACTION', value: 'plan';
            }
            steps {
                sh 'terraform plan'
            }
        }

        stage('Infrastructure Apply') {
            when {
                environment name: 'ACTION', value: 'apply';
            }
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Infrastructure Destroy') {
            when {
                environment name: 'ACTION', value: 'destroy';
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}