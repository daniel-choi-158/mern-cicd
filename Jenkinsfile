node('docker') {
    stage 'clean out any containers and images'
        sh "docker rm $(docker ps -aq)"
        sh "docker rmi $(docker images -q)"
    
    stage 'Checkout fresh code'
        checkout scm

    //stage 'Build & UnitTest'
    //    sh "docker build -t accountownerapp:B${BUILD_NUMBER} -f Dockerfile ."
    //    sh "docker build -t accountownerapp:test-B${BUILD_NUMBER} -f Dockerfile.Integration ."
    stage 'Integration Test'
        sh "docker-compose -f docker-compose.yml up --force-recreate --abort-on-container-exit"
        sh "docker-compose -f docker-compose.yml down -v"
}