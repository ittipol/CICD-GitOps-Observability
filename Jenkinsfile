def customImage

pipeline {
  agent any
  environment { 
    // AN_ACCESS_KEY = credentials('eebb88dd-be42-429e-b685-2c4904c65f7f') 
    GIT_URL = "https://github.com/ittipol/Jenkins.git"
    DOCKER_REGISTER = "https://registry:5000"
    DOCKER_REGISTER_CREDENTIAL = "f255e9a3-a6f7-4980-ae1c-a2226a342f6a"
    SCANNER_HOME = tool 'sonarqube-scanner-tool';
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
            // Clean before build
            cleanWs()
            // We need to explicitly checkout from SCM here
            // ‘checkout scm’ is only available when using “Multibranch Pipeline” or “Pipeline script from SCM”
            // checkout scm
            echo "Building ${env.JOB_NAME}..."
        }
    }
    stage('Git checkout') {
      steps {
        git branch: 'main', changelog: false, poll: false, url: env.GIT_URL
      }
    }
    stage('Test') {      
      when {
          expression {
              params.executeTest == true
          }
      }
      steps {
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
            dependencyCheck additionalArguments: ''' 
                        -o './'
                        -s './'
                        -f 'ALL' 
                        --prettyPrint''', odcInstallation: 'Dependency-Check'
            
            dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
    }
    stage('Sonarqube scan') {      
      steps {
        withSonarQubeEnv('sonarqube-server') {
            sh '''
            $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Go-App \
            -Dsonar.java.binary=. \
            -Dsonar.projectKey=Go-App
            '''
        }
      }
    }
    stage('Build image') {      
      steps {
        // sh '''
        // cd src
        // docker build -t go-app:v1 .
        // '''
        script {
          dir('src') {
            echo "Tag name: ${params.tagVersion}"
            customImage = docker.build("go-app:v1")
          }
        }
      }
    }
    stage('Push image') {      
      steps {
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
  // post {
  //     // Clean after build
  //     always {
  //         cleanWs(cleanWhenNotBuilt: false,
  //                 deleteDirs: true,
  //                 disableDeferredWipeout: true,
  //                 notFailBuild: true,
  //                 patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
  //                             [pattern: '.propsfile', type: 'EXCLUDE']])
  //     }
  // }
}