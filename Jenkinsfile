
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
        TF_VAR_aws_eip_alloc_id = credentials('aws_eip_alloc_id')
        TF_VAR_aws_ebs_volume_id = credentials('aws_ebs_volume_id')
        
        TF_VAR_db_host = credentials('db_host')
        TF_VAR_db_name = credentials('db_name')
        TF_VAR_db_user = credentials('db_user')
        TF_VAR_db_pass = credentials('db_pass')
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