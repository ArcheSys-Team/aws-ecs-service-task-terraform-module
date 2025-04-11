@Library('CISharedLibraries@master') _

pipeline {
    agent {
        kubernetes {
            yaml """
---
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: prod-jenkins-core-assumerole
  nodeSelector:
    Agents: true
  containers:
    - name: awscli
      image: artifactory.cms.gov/jenkins-core-docker/amazon/aws-cli:latest
      imagePullPolicy: Always
      tty: true
      command:
        - cat
    - name: jq
      image: artifactory.cms.gov/jenkins-core-docker/ocf-jq:latest
      imagePullPolicy: Always
      tty: true
      command:
        - cat
    - name: tf
      image: "hashicorp/terraform:latest"
      tty: true
      command: ["tail", "-f", "/dev/null"]
      imagePullPolicy: Always
            """
        }
    }

    options { timestamps() }

    stages {
        stage('Prepare Environment') {
            steps {
                container('tf') {
                    withCredentials([usernamePassword(credentialsId: 'OCSA4', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                        sh """
                        echo "Setting up environment"
                        echo "machine github.cms.gov login $GIT_USERNAME password $GIT_PASSWORD" > ~/.netrc
                        chmod 600 ~/.netrc
                        """
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                container('tf') {
                    sh """
                    echo "Initializing Terraform"
                    ls
                    pwd
                    cd ./oc-example/unit-testing
                    ls
                    terraform init
                    """
                }
            }
        }

        stage('Parallel TF Lint, Validate and Test') {
            parallel {
                stage('Terraform Lint and Validate') {
                    steps {
                        container('tf') {
                            script {
                                // Lint for both modules
                                def lintResulteks = sh(script: 'terraform fmt -check -recursive ./oc-example/ecs-cluster-type-fargate', returnStatus: true)
                                if (lintResulteks != 0) {
                                    error("Terraform linting failed. Please run 'terraform fmt -recursive' to fix formatting issues.")
                                }
                            }
                        }
                    }
                }
                stage('Terraform Validate') {
                    steps {
                        container('tf') {
                            sh """
                            echo "Validating Terraform configuration"
                            terraform validate
                            """
                        }
                    }
                }

                stage('Terraform Test') {
                    steps {
                        container('awscli') {
                            echo "*******Before*******"
                            sh('aws sts get-caller-identity')
                        }

                        awsAssumeRoleInEnv("arn:aws:iam::180672039436:role/delegatedadmin/developer/pocs-dev-jenkins-cross-account");

                        container('awscli') {
                            echo "*******After*******"
                            sh('aws sts get-caller-identity')
                        }

                        container('tf') {
                            sh """
                            # Test for ecs cluster
                            cd ./oc-example/unit-testing
                            terraform init
                            echo "Running Terraform tests for ecs cluster"
                            terraform test

                            """
                        }
                    }
                }
            }
        }

        stage('Parallel TF plan all examples') {
            when {
                expression { env.BRANCH_NAME != 'main' }
            }
            parallel {
                stage('Terraform Plan complete-ecs') {
                    steps {
                        container('awscli') {
                            echo "*******Before*******"
                            sh('aws sts get-caller-identity')
                        }

                        awsAssumeRoleInEnv("arn:aws:iam::180672039436:role/delegatedadmin/developer/pocs-dev-jenkins-cross-account");

                        container('awscli') {
                            echo "*******After*******"
                            sh('aws sts get-caller-identity')
                        }

                        container('tf') {
                            sh """
                            cd ./oc-example/ecs-cluster-type-fargate
                            echo "Planning Terraform changes"
                            terraform init -reconfigure -backend-config="alb-and-ecs-cluster-backend.conf"
                            terraform plan -target=module.iam -target=module.network -target=module.oc-tags -target=module.security-groups -target=module.alb -target=module.ecs-cluster-fargate-module
                            terraform init -reconfigure -backend-config="ecs-cluster-task-and-service-backend.conf"
                            terraform plan -target=module.iam -target=module.network -target=module.oc-tags -target=module.security-groups -target=module.ecs-cluster-task-and-service
                            terraform init -reconfigure -backend-config="rds-mysql-backend.conf"
                            terraform plan -target=module.iam -target=module.network -target=module.oc-tags -target=module.security-groups -target=module.rds-mysql
                            """
                        }
                    }
                }
            }
        }

        stage('Parallel TF apply all examples') {
            when {
                expression { env.BRANCH_NAME == 'main' }
            }
            parallel {
                stage('Terraform Apply complete-ecs') {
                    steps {
                        container('awscli') {
                            echo "*******Before*******"
                            sh('aws sts get-caller-identity')
                        }

                        awsAssumeRoleInEnv("arn:aws:iam::180672039436:role/delegatedadmin/developer/pocs-dev-jenkins-cross-account");

                        container('awscli') {
                            echo "*******After*******"
                            sh('aws sts get-caller-identity')
                        }

                        container('tf') {
                            sh """
                            cd ./oc-example/ecs-cluster-type-fargate
                            echo "Planning Terraform changes"
                            terraform init -reconfigure -backend-config="alb-and-ecs-cluster-backend.conf"
                            terraform apply -target=module.iam -target=module.network -target=module.oc-tags -target=module.security-groups -target=module.alb -target=module.ecs-cluster-fargate-module -auto-approve
                            terraform init -reconfigure -backend-config="ecs-cluster-task-and-service-backend.conf"
                            terraform apply -target=module.iam -target=module.network -target=module.oc-tags -target=module.security-groups -target=module.ecs-cluster-task-and-service -auto-approve
                            terraform init -reconfigure -backend-config="rds-mysql-backend.conf"
                            terraform apply -target=module.iam -target=module.network -target=module.oc-tags -target=module.security-groups -target=module.rds-mysql -auto-approve
                            """
                        }
                    }
                }
            }
        }
    }
}
