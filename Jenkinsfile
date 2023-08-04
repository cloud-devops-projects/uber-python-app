pipeline {
    agent any
    stages {
        stage("testing application") {
            steps {
                script {
                    echo "testing uber python application..."
                    // sh 'python -m venv venv'
                    // sh 'source venv/bin/activate && pip install -r requirements-test.txt'
                    // sh 'source venv/bin/activate && python test/test_endpoints.py'         
                }
            }
        }
        stage("building application") {
            steps {
                script {
                    echo "building uber python application..."
                    echo "ok"
                    // sh 'mkdir build'
                    // sh 'cp -R src/* build/'
                    // sh 'python -m venv build/venv'
                    // sh 'source build/venv/bin/activate && pip install -r build/requirements.txt'
                    // sh 'source build/venv/bin/activate && pyinstaller --onefile --distpath build/dist/ app.py'        
                }
            }
        }
        /*stage("build docker image and deploy to AWS ECR Repo") {
            environment {
                IMAGE_NAME = "$BUILD_NUMBER"
            }
            steps {
                script {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'ecr-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t AWS-ECR-Repo/uber-python-app:$IMAGE_NAME build/"
                        sh "echo $PASS | docker login -u $USER --password-stdin AWS-ECR-Repo"
                        sh 'docker push AWS-ECR-Repo/uber-python-app:$IMAGE_NAME'
                    }
                }
            }
        }
        stage("deploy to k8s cluster") {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_secret_access_key')
                AWS_REGION = credentials('jenkins_aws_region')
            }
            steps {
                script {
                    echo 'deploying docker image to EKS Cluster...'
                    sh ' kubectl apply -f kubernetes/uber-python-app.yml'
                }
            }
        }*/
    }   
}
