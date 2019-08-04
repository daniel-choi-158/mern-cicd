node('docker') {
    //stage 'clean out any containers and images'
    //    sh "docker rm --force \$(docker ps -aq)"
    //    sh "docker rmi \$(docker images -q)"
    
    stage 'Checkout fresh code'
        checkout scm

    stage 'Build & UnitTest'
        sh "docker build -t mongo:B${BUILD_NUMBER} -f ./mongo/Dockerfile ./mongo/"
        sh "docker build -t backend:B${BUILD_NUMBER} -f ./backend/Dockerfile ./backend/"
        sh "docker build -t frontend:B${BUILD_NUMBER} -f ./frontend/Dockerfile ./frontend/"

    stage 'Integration Test'
        sh "docker-compose -f docker-compose.yml up --force-recreate --abort-on-container-exit"
        sh "docker-compose -f docker-compose.yml down -v"
}