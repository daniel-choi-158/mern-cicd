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
        //sh "docker build -t mongo:B${BUILD_NUMBER} -f ./mongo/Dockerfile ./mongo/"
        //sh "docker build -t backend:B${BUILD_NUMBER} -f ./backend/Dockerfile ./backend/"
        //sh "docker build -t frontend:B${BUILD_NUMBER} -f ./frontend/Dockerfile ./frontend/"
        def mongoImage = docker.build("mongo:B${BUILD_NUMBER}","-f ./mongo/Dockerfile ./mongo/")
        def backendImage = docker.build("backend:B${BUILD_NUMBER}","-f ./backend/Dockerfile ./backend/")
        def frontendImage = docker.build("frontend:B${BUILD_NUMBER}","-f ./frontend/Dockerfile ./frontend/")
        // add unit test

    stage 'Integration Test'
        sh "docker-compose -f docker-compose.yml up --force-recreate --abort-on-container-exit"
        sh "docker-compose -f docker-compose.yml down -v"

    stage 'send to docker registry'
    //    sh "docker.build registry + \":$BUILD_NUMBER\""
        sh "docker tag mongo danielchoi158/mern-cicd:mongo"
        sh "docker tag backend danielchoi158/mern-cicd:backend"
        sh "docker tag frontend danielchoi158/mern-cicd:frontend"
        withDockerRegistry([url: "",credentialsId: "dockerhub"]) {
            mongoImage.push('latest')
            backendImage.push('latest')
            backendImage.push('latest')
        }
}