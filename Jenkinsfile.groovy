//import groovy.json.JsonSlurper
node {
    stage('Clone repository') {
        // Let's make sure we have the repository cloned to our workspace
            
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'git', url: 'https://github.com/naveenganji/api-gateway.git']]])
    
		}
		
    
	stage('Deploy-create-update') { 
			// Example AWS credentials 
			
			def tplTitle = readJSON file: "$WORKSPACE/omsproxynav.json.tpl"
			echo tplTitle.info.title.toString()
			
			withCredentials( [[ $class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'jenkinsAwsCredentials',
			secretKeyVariable: 'AWS_SECRET_ACCESS_KEY' ]]) {
				//sh 'OUTPUT=$(docker run -e "AWS_DEFAULT_REGION=us-east-1" -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -v /var/lib/jenkins/workspace/sampletest/:/code/ docker.io/mesosphere/aws-cli apigateway get-rest-apis)'
				//sh 'echo $OUTPUT'
				def out = sh( script: 'docker run -e "AWS_DEFAULT_REGION=us-east-1" -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -v /var/lib/jenkins/workspace/sampletest/:/code/ docker.io/mesosphere/aws-cli apigateway get-rest-apis', returnStdout: true).trim()
			   
			   def isPresent=""
			   def id=""
			   
			   def stringJSON= out.toString()
			   def object = readJSON text: stringJSON
			  // echo object.toString()
			   for(int i=0;i<object.items.size();i++)
			   {
			       if(object.items[i].name.toString()==tplTitle.info.title.toString())
			       {
			           isPresent="true"
			           id= object.items[i].id.toString()
			       }
			   }
			   
			
			  if(isPresent=="true")
			   {
			       sh 'echo updating'
				  sh "docker run -e \"AWS_DEFAULT_REGION=us-east-1\" -e \"AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}\" -e \"AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}\" -v $WORKSPACE/:/code/ docker.io/mesosphere/aws-cli apigateway put-rest-api --rest-api-id ${id} --mode overwrite --parameters endpointConfigurationTypes=EDGE --body file:///code/omsproxynav.json.tpl"
			   }
			   else
			   {
				   sh 'echo creating'
				   sh 'docker run -e "AWS_DEFAULT_REGION=us-east-1" -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -v $WORKSPACE/:/code/ docker.io/mesosphere/aws-cli apigateway import-rest-api --parameters endpointConfigurationTypes=EDGE --body file:///code/omsproxynav.json.tpl'
			   }
		}
}
 
    /*stage('Deploy') { 
		        // Example AWS credentials 
		        withCredentials( [[ $class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'jenkinsAwsCredentials',
		        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY' ]]) {
		            sh 'docker run -e "AWS_DEFAULT_REGION=us-east-1" -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -v /var/lib/jenkins/workspace/sampletest/:/code/ docker.io/mesosphere/aws-cli apigateway put-rest-api --rest-api-id sp1svitvr2 --mode overwrite --parameters endpointConfigurationTypes=EDGE --body file:///code/omsproxynav.json.tpl'
		            
		            
		    }
    }*/
	
    }

