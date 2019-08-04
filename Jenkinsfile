node('docker') {
    //stage 'clean out any containers and images'
    //    sh "docker rm --force \$(docker ps -aq)"
    //    sh "docker rmi \$(docker images -q)"

    //environment
    //    registry = "docker_hub_account/repository_name"
    //    registryCredential = ‘dockerhub’
    
    stage 'Checkout fresh code'
        checkout scm

    stage 'Build & UnitTest'
        def image-mongo = sh "docker build -t mongo:B${BUILD_NUMBER} -f ./mongo/Dockerfile ./mongo/"
        def image-backend = sh "docker build -t backend:B${BUILD_NUMBER} -f ./backend/Dockerfile ./backend/"
        def image-frontend = sh "docker build -t frontend:B${BUILD_NUMBER} -f ./frontend/Dockerfile ./frontend/"
        // add unit test

    stage 'Integration Test'
        sh "docker-compose -f docker-compose.yml up --force-recreate --abort-on-container-exit"
        sh "docker-compose -f docker-compose.yml down -v"

    stage 'send to docker registry'
    //    sh "docker.build registry + \":$BUILD_NUMBER\""
        image-mongo.push('latest')
        image-backend.push('latest')
        image-frontend.push('latest')
}