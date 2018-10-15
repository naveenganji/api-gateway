pipeline {
	agent any
	
	stages {
		stage('stage1') {
        /* Let's make sure we have the repository cloned to our workspace */
        //checkout scm
        }
             
        stage("stage2") {
			//steps {
				//sh 'sudo apt-get install python3'
                //sh 'sudo pip install awscli'
			//}
		}
		
        stage("stage3") {
			//steps {
				//sh 'aws apigateway import-rest-api --parameters ignore=documentation endpointConfigurationTypes=EDGE --body 'file:///swagger-test-api.json'
			//}
		}
    }
}
