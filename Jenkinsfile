pipeline{
    agent{
        node{
            label 'ROBOSHOP'
        }
    }
    environment{
        appVersion=""
        acc_id="003252302882"
        region="us-east-1"
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
        stage('install dependencies'){
            steps{
              script{
                sh """
                  npm install 
                  """
                    }                         
                 }
        }
        stage('Build docker'){
            steps{
                script{
                    withAWS(credentials: 'aws-cred', region: "${region}"){
/*                     sh """
                       aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin 
                       ${acc_id}.dkr.ecr.us-east-1.amazonaws.com
                       docker build -t ${acc_id}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion} .
                       docker push ${acc_id}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:latest
                    """ */
                    sh '''
                          echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
                          echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
                          echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"

                          aws sts get-caller-identity
                        '''
                }
            }
                
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