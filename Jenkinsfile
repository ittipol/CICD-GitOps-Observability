def customImage

pipeline {
  agent any
  environment { 
    // AN_ACCESS_KEY = credentials('eebb88dd-be42-429e-b685-2c4904c65f7f') 
    GIT_URL = "https://github.com/ittipol/Jenkins.git"
    DOCKER_REGISTER = "https://registry:5000"
    DOCKER_REGISTER_CREDENTIAL = "8a0ba98b-130f-4ee6-b41b-af423112fd4c"
    SCANNER_HOME = tool 'sonarqube-scanner-tool'
    WEBHOOK_SECRET_ID= "6641b7ca-2507-4f23-bfce-f5fc86136b2f"
    PROJECT_KEY= "Go-App"
  }
  parameters {
    string(name: 'tagVersion', defaultValue: '', description: 'Tag version')
    booleanParam(name: 'executeTest', defaultValue: true, description: '')
    booleanParam(name: 'owaspScan', defaultValue: true, description: 'OWASP Dependency-Check Vulnerabilities')
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
        echo '******************************'
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
        echo '******************************'
        // We need to explicitly checkout from SCM here
        // ‘checkout scm’ is only available when using “Multibranch Pipeline” or “Pipeline script from SCM”
        // checkout scm
        git branch: 'main', changelog: false, poll: false, url: env.GIT_URL
        // sh 'env'
        // sh '''
        // ls -l
        // '''
      }
    }
    stage('Test') {      
      when {
          expression {
              params.executeTest == true
          }
      }
      steps {
        echo '******************************'
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
    stage('OWASP Dependency-Check Vulnerabilities') {     
        when {
            expression {
                params.owaspScan == true
            }
        }
        steps {
          echo '******************************'
          dependencyCheck additionalArguments: ''' 
                      -o './'
                      -s './src'
                      -f 'ALL' 
                      --prettyPrint''', odcInstallation: 'Dependency-Check'
          
          dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
    }
    stage('Sonarqube analysis') {            
      steps {
        echo '******************************'
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
        echo '******************************'
        timeout(time: 1, unit: 'HOURS') {
            // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
            // true = set pipeline to UNSTABLE, false = don't
            waitForQualityGate abortPipeline: true, webhookSecretId: env.WEBHOOK_SECRET_ID
        }
      }
    }
    stage('Build image') {      
      steps {
        echo '******************************'
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
            customImage = docker.build("go-app:${params.tagVersion}")
          }
        }
      }
    }
    stage('Push image') {      
      steps {
        echo '******************************'
        // sh '''
        // docker login -u docker -p 1234 https://registry:5000
        // docker tag go-app:v1 registry:5000/go-app:v1
        // docker push registry:5000/go-app:v1
        // '''
        script {
          docker.withRegistry(env.DOCKER_REGISTER, env.DOCKER_REGISTER_CREDENTIAL) {
            // sh '''
            // docker tag go-app:v1 registry:5000/go-app:v1
            // docker push registry:5000/go-app:v1
            // '''
            customImage.push()
          }
        }
      }
    }
  }
  post {      
    // always {
    //     // Clean after build
    //     cleanWs(cleanWhenNotBuilt: false,
    //             deleteDirs: true,
    //             disableDeferredWipeout: true,
    //             notFailBuild: true,
    //             patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
    //                         [pattern: '.propsfile', type: 'EXCLUDE']])
    // }
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