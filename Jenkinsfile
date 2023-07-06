pipeline {
    agent any
    stages {
        stage("testing application") {
            steps {
                script {
                    echo "testing uber python application..."
                    sh 'python -m venv venv'
                    sh 'source venv/bin/activate && pip install -r requirements-test.txt'
                    sh 'source venv/bin/activate && python test/test_endpoints.py'         
                }
            }
        }
        stage("building application") {
            steps {
                script {
                    echo "building uber python application..."
                    sh 'mkdir build'
                    sh 'cp -R src/* build/'
                    sh 'cp requirements.txt build/'
                    sh 'cp app.py build/'
                    sh 'python -m venv build/venv'
                    sh 'source build/venv/bin/activate && pip install -r build/requirements.txt'
                    sh 'source build/venv/bin/activate && pyinstaller --onefile --distpath build/dist/ app.py'        
                }
            }
        }
        stage("build docker image and deploy to AWS ECR Repo") {
            steps {
                script {
                    echo "building the docker image..."
                    sh 'cp Dockerfile build/'
                    withCredentials([usernamePassword(credentialsId: 'ecr-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t [AWS ECR Repo]/uber-python-app:${env.BUILD_NUMBER} build/"
                        sh "echo $PASS | docker login -u $USER --password-stdin [AWS ECR Repo]"
                        sh 'docker push [AWS ECR Repo]/uber-python-app:${env.BUILD_NUMBER}'
                    }
                }
            }
        }
        stage("deploy to k8s cluster") {
            steps {
                script {}
            }
        }
    }   
}