pipeline {
    agent any
    stages {
        stage("increment version") {
            steps {
                script {
                    echo "incrementing app version"
                }
            }
        }
        stage("testing application") {
            steps {
                script {
                    echo "testing uber python application..."
                    sh 'pip install -r requrirements-test.txt'
                    sh "python3 test/test_endpoints.py"          
                }
            }
        }
        stage("building application") {
            steps {
                script {
                    echo "building uber python application..."
                    sh 'pip install -r requrirements.txt'
                    sh "python3 app.py"          
                }
            }
        }
        stage("build docker image and deploy to AWS ECR Repo") {
            steps {
                script {}
            }
        }
        stage("deploy to k8s cluster") {
            steps {
                script {}
            }
        }
    }   
}