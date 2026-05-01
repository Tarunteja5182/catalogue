pipeline{
    agent{
        node{
            label 'ROBOSHOP'
        }
    }
    environment{
        appversion=""
    }
    stages{
        stage('Read version'){
            steps {
                script {
                    // Load and parse the JSON file
                    def packageJson = readJSON file: 'package.json'
                    
                    // Access fields directly
                    appVersion = packageJson.version
                    echo "Building version ${appVersion}"
                }
            }
        }
        stage(install dependencies){
            steps{
              script{
                sh """
                  npm install 
                  """
                    }                         
                 }
        }
        stage(Build docker){
            steps{
                docker build -t catalogue:${appversion} .
            }
        }
    }
    post{
        success{
            echo "pipeline is sucesfull"
        }
        failure{
            echo "Pipeline is failed, please check the log"
        }
    }
}