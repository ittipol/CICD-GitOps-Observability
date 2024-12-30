def customImage

pipeline {
  agent any
  environment { 
    GIT_URL = "https://github.com/ittipol/Gitops.git"
    GIT_CREDENTIAL = "gitops-cred"
    DOCKER_REGISTRY = "https://registry:5000"
    DOCKER_REGISTRY_CREDENTIAL = "8a0ba98b-130f-4ee6-b41b-af423112fd4c"
    REGISTRY_REPO = "go-app"
    SCANNER_HOME = tool 'sonarqube-scanner-tool'
    WEBHOOK_SECRET_ID = "6641b7ca-2507-4f23-bfce-f5fc86136b2f"
    PROJECT_KEY = "Go-App"
    JENKINS_API_TOKEN = credentials('jenkins-api-token')
  }
  parameters {
    string(name: 'tagVersion', defaultValue: '', description: 'Tag version')
    booleanParam(name: 'executeTest', defaultValue: true, description: '')
    // booleanParam(name: 'owaspScan', defaultValue: true, description: 'OWASP Dependency-Check Vulnerabilities')
  }
  tools {
    go 'go'
  }
  options {
      // This is required if you want to clean before build
      skipDefaultCheckout(true)
  }
  stages {
    stage('Init') {
      steps {
        echo '************************************************************'
        // Clean before build
        cleanWs()        
        echo "Building ${env.JOB_NAME}..."

        script {
          if(params.tagVersion.isEmpty()) {
            error("tagVersion parameter is empty")
          }
        }
      }
    }
    stage('Git checkout') {
      steps {
        echo '************************************************************'
        // We need to explicitly checkout from SCM here
        // ‘checkout scm’ is only available when using “Multibranch Pipeline” or “Pipeline script from SCM”
        // checkout scm
        git branch: 'main', changelog: false, credentialsId: env.GIT_CREDENTIAL, poll: false, url: env.GIT_URL
        // sh 'env'
      }
    }
    stage('Test') {      
      when {
          expression {
              params.executeTest == true
          }
      }
      steps {
        echo '************************************************************'
        // sh '''
        // cd src
        // go test ./...
        // '''
        script {
          dir('src') {
            sh 'go test ./...'
          }
        }
      }
    }
    // stage('OWASP Dependency-Check Vulnerabilities') {     
    //     when {
    //       expression {
    //         params.owaspScan == true
    //       }
    //     }
    //     steps {
    //       echo '************************************************************'
    //       dependencyCheck additionalArguments: ''' 
    //                   -o './'
    //                   -s './src'
    //                   -f 'ALL' 
    //                   --prettyPrint''', odcInstallation: 'Dependency-Check'
          
    //       dependencyCheckPublisher pattern: 'dependency-check-report.xml'
    //     }
    // }
    stage('Sonarqube analysis') {            
      steps {
        echo '************************************************************'
        withSonarQubeEnv('sonarqube-server') {
            sh '''
            $SCANNER_HOME/bin/sonar-scanner \
            -Dsonar.projectKey=$PROJECT_KEY \
            -Dsonar.projectVersion=$tagVersion \
            -Dsonar.projectName="Go App" \
            -Dsonar.sources=./src
            '''
        }    
      }
    }
    stage("Quality Gate") {
      steps {
        echo '************************************************************'
        timeout(time: 1, unit: 'HOURS') {
            // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
            // true = set pipeline to UNSTABLE, false = don't
            waitForQualityGate abortPipeline: true, webhookSecretId: env.WEBHOOK_SECRET_ID
        }
      }
    }
    stage('Build image') {      
      steps {
        echo '************************************************************'
        // sh '''
        // cd src
        // docker build -t go-app:v1 .
        // '''
        script {
          dir('src') {
            // if(params.tagVersion.isEmpty()) {
            //     error("tagVersion is empty")
            // }else {
            //     echo "Tag version: ${params.tagVersion}"
            //     customImage = docker.build("go-app:${params.tagVersion}")
            // }
            echo "Tag version: ${params.tagVersion}"
            customImage = docker.build("${env.REGISTRY_REPO}:${params.tagVersion}")
          }
        }
      }
    }
    stage('Push image') {      
      steps {
        echo '************************************************************'
        // sh '''
        // docker login -u docker -p 1234 https://registry:5000
        // docker tag go-app:v1 registry:5000/go-app:v1
        // docker push registry:5000/go-app:v1
        // '''
        script {
          docker.withRegistry(env.DOCKER_REGISTRY, env.DOCKER_REGISTRY_CREDENTIAL) {
            // sh '''
            // docker tag go-app:v1 registry:5000/go-app:v1
            // docker push registry:5000/go-app:v1
            // '''
            customImage.push()            
          }
        }
      }
    }
    // stage('Delete image') {      
    //   steps {
    //     echo '************************************************************'
    //     // sh 'docker system prune --force --all --volumes'
    //     sh "docker rmi -f ${customImage.id}"
    //     // sh '''
    //     // export IMAGE_ID=$(docker images --filter=reference=$REGISTRY_REPO:$tagVersion --format "{{.ID}}")
    //     // docker rmi -f $IMAGE_ID
    //     // '''
    //   }
    // }
    stage('Trigger CD Pipeline') {   
      steps {
        echo '************************************************************'

        script {
          // Trigger builds remotely
          sh "curl -kv --user test:$JENKINS_API_TOKEN -X POST -H 'Cache-Control: no-cache' -H 'Content-Type: application/x-www-form-urlencoded' --data 'TAG=$tagVersion' --location 'http://localhost:8080/job/cd-pipeline/buildWithParameters'"
        }
      }
    }
  }
  post {      
    always {
      // Clean after build
      cleanWs(cleanWhenNotBuilt: false,
              deleteDirs: true,
              disableDeferredWipeout: true,
              notFailBuild: true,
              patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                          [pattern: '.propsfile', type: 'EXCLUDE']])
    }
    success {
        echo "Build ID: ${BUILD_ID}, ${JOB_NAME} succeeded"
    }
    failure {
        // mail to: team@example.com, subject: 'The Pipeline failed :('
        echo "Build ID: ${BUILD_ID}, ${JOB_NAME} failed"
    }
    aborted {
        echo "Build ID: ${BUILD_ID}, ${JOB_NAME} aborted"
    }
  }
}