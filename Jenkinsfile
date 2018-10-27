pipeline {
    agent {
        docker {
            image 'node:6-alpine'
            args '-p 3000:3000'
        }
    }
    environment {
        CI = 'true'
        NODE_ORACLEDB_CREDS = credentials('msb-msitm')
    }
    stages {
        stage('Setup Environment') {
            steps {
                sh 'cp -r /home/oracle-env .'
            }
        }
        stage('Build') { 
            steps {
                sh 'npm install' 
                sh 'npm install --only=dev'
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver') {
            steps {
                sh './jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}
