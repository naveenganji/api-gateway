# omsproxy-swagger

Swagger definition for OMS Proxy

The following placeholders have to be replaced before this swagger definition can be imported into API Gateway:

| Name | Description |
| ---- | ----------- |
| `aws_account_id` | AWS Account ID. Example: 496564055646 |
| `env_name` | Name of the environment: `dev`, `qa`, `stage`, or nothing for Production |
| `region` | Name of the AWS region the Rest API is deployed to. Example: `us-west-2` |
| `timeout` | Timeout in milliseconds. Example: 15000 |

DO NOT replace placeholders starting with `${stageVariables.`, they will be replaced by API Gateway. See [Set up Stage Variable for API Deployment](https://docs.aws.amazon.com/apigateway/latest/developerguide/stage-variables.html) for details.

## Performance testing profile
[perftest.yml](perftest.yml) file contains scenarios for [Artillery.io](https://artillery.io/) performance testing framework.

### Initial set up
Clone this repository and run `npm install` command to install Node.js modules.  
Weights were taken from [BOPIS Performance and Load requirements | ShopApp](https://lululemon.atlassian.net/wiki/spaces/MAC/pages/659980980/BOPIS+Performance+and+Load+requirements+ShopApp) Confluence page.

### Run a test
To run a test make sure `AWS_REGION`, `AWS_ACCESS_KEY_ID`, and `AWS_SECRET_ACCESS_KEY` environment variables are set and run the following command:
```
./node_modules/.bin/artillery run -e stage perftest.yml
```
where `stage` is name of the environment to run tests against. Available environments: `dev`, `qa`, `stage`.

Default load is 2 calls per second for 10 seconds. To override this add `--overrides '{"config": {"phases": [{"duration": 60, "arrivalRate": 5}]}}'` switch with desired numbers.

5 calls per second for 5 minutes
```
./node_modules/.bin/artillery run -e stage --overrides '{"config": {"phases": [{"duration": 300, "arrivalRate": 5}]}}' perftest.yml
```
