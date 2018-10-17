node {
  stage('Checkout') {
    checkout scm
  }
 
  stage('Deploy') {
    def aws_credentials_id
 
    // Set environment variables based on branch name
    withFolderProperties {
      if (env.BRANCH_NAME == 'master') {
        env.API_STAGE_NAME = 'prod'
        env.REST_API_NAME = 'omsproxy'
        aws_credentials_id = 'jenkinsAwsCredentials'
        env.AWS_DEFAULT_REGION = env.AWS_DEFAULT_REGION_PROD
        env.API_TIMEOUT = env.API_TIMEOUT_PROD
      } else {
        env.API_STAGE_NAME = env.BRANCH_NAME
        env.REST_API_NAME = "omsproxy-${env.BRANCH_NAME}"
        aws_credentials_id = 'jenkinsAwsCredentials'
        env.AWS_DEFAULT_REGION = env.AWS_DEFAULT_REGION_NONPROD
        env.API_TIMEOUT = env.API_TIMEOUT_NONPROD
      }
    }
 
    // Deploy new Swagger definition
    withCredentials([[
      $class: 'AmazonWebServicesCredentialsBinding',
      credentialsId: aws_credentials_id,
      accessKeyVariable: 'AWS_ACCESS_KEY_ID',
      secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
    ]]) {
      docker.image('mesosphere/aws-cli').withRun('--entrypoint /bin/sh', '') {
        sh """
          AWS_ACCOUNT_ID=\$(aws sts get-caller-identity --output text --query 'Account')
          echo "Retrieving ID of \$REST_API_NAME REST API ..."
          REST_API_ID=\$(aws apigateway get-rest-apis --no-paginate --output text --query "items[?name==\\`\${REST_API_NAME}\\`].[id]")
          echo "Deploying Swagger definition for \$REST_API_NAME (\$REST_API_ID) ..."
          sed "s#\\\${env_name}#\${API_STAGE_NAME}#g; s#\\\${region}#\${AWS_DEFAULT_REGION}#g; s#\\\${timeout}#\${API_TIMEOUT}#g; s#\\\${aws_account_id}#\${AWS_ACCOUNT_ID}#g" omsproxynav.json.tpl > omsproxy.json
          aws apigateway put-rest-api --rest-api-id "\${REST_API_ID}" --mode overwrite --parameters endpointConfigurationTypes=REGIONAL --body "file://\$(pwd)/omsproxynav.json"
          echo "Creating new deployment for \$API_STAGE_NAME stage ..."
          aws apigateway create-deployment --rest-api-id "\${REST_API_ID}" --stage-name "\${API_STAGE_NAME}" --description "Deployed by Jenkins job: \${JOB_NAME}, build: \${BUILD_NUMBER}"
        """
      }
    }
  }
}
