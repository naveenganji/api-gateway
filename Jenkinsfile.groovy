pipeline {
	agent any
	
	stages {
		stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        //checkout scm
        }
             
        stage("Install AWSCLI") {
			steps {
				//sh 'sudo apt-get install python3'
                //sh 'sudo pip install awscli'
			}
		}
		
        stage("Deploy") {
			steps {
				//sh 'aws apigateway import-rest-api --parameters ignore=documentation endpointConfigurationTypes=EDGE --body 'file:///swagger-test-api.json'
			}
		}
    }
}
