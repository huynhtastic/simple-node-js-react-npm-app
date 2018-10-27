pipeline {
    agent {
        docker {
            image 'node:6-alpine'
            args '-p 3000:3000'
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Setup Environment') {
            environment {
                NODE_ORACLEDB_CREDS = credentials('msb-msitm')
            }
            steps {
                sh 'export NODE_ORACLEDB_USER=$NODE_ORACLEDB_CREDS_USR'
                sh 'export NODE_ORACLEDB_PASSWORD=$NODE_ORACLEDB_CREDS_PSW'
                sh 'export LD_LIBRARY_PATH=./oracle-env/instantclient_18_3'
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
