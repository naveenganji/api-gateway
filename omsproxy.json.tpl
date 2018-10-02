{
  "swagger": "2.0",
  "info": {
    "version": "2018-08-11T05:24:15Z",
    "title": "omsproxy-${env_name}"
  },
  "host": "*.execute-api.${region}.amazonaws.com",
  "basePath": "/",
  "schemes": [
    "https"
  ],
  "paths": {
    "/availableproducts": {
      "post": {
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "200 response",
            "schema": {
              "$ref": "#/definitions/Empty"
            },
            "headers": {
              "content-type": {
                "type": "string"
              }
            }
          }
        },
        "security": [
          {
            "sigv4": []
          }
        ],
        "x-amazon-apigateway-integration": {
          "uri": "https://${stageVariables.albFriendlyHostname}/smcfs/restapi/executeFlow/getAvailableProducts",
          "responses": {
            "default": {
              "statusCode": "200",
              "responseParameters": {
                "method.response.header.content-type": "'application/json'"
              }
            }
          },
          "requestParameters": {
            "integration.request.header.Authorization": "stageVariables.omsAuthToken"
          },
          "passthroughBehavior": "when_no_templates",
          "timeoutInMillis": ${timeout},
          "httpMethod": "POST",
          "type": "http_proxy",
          "connectionType": "VPC_LINK",
          "connectionId": "${stageVariables.vpcLinkId}"
        }
      }
    },
    "/cancelorder": {
      "post": {
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "200 response",
            "schema": {
              "$ref": "#/definitions/Empty"
            },
            "headers": {
              "content-type": {
                "type": "string"
              }
            }
          }
        },
        "security": [
          {
            "sigv4": []
          }
        ],
        "x-amazon-apigateway-integration": {
          "uri": "https://${stageVariables.albFriendlyHostname}/smcfs/restapi/executeFlow/cancelGuestOrder",
          "responses": {
            "default": {
              "statusCode": "200",
              "responseParameters": {
                "method.response.header.content-type": "'application/json'"
              }
            }
          },
          "requestParameters": {
            "integration.request.header.Authorization": "stageVariables.omsAuthToken",
            "integration.request.header.X-XAPI-Tag": "'Order'"
          },
          "passthroughBehavior": "when_no_templates",
          "timeoutInMillis": ${timeout},
          "httpMethod": "POST",
          "type": "http_proxy",
          "connectionType": "VPC_LINK",
          "connectionId": "${stageVariables.vpcLinkId}"
        }
      }
    },
    "/healthcheck": {
      "post": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "200 response",
            "schema": {
              "$ref": "#/definitions/Empty"
            },
            "headers": {
              "content-type": {
                "type": "string"
              }
            }
          }
        },
        "security": [
          {
            "sigv4": []
          }
        ],
        "x-amazon-apigateway-integration": {
          "uri": "https://${stageVariables.albFriendlyHostname}/smcfs/restapi/executeFlow/getAvailableProducts",
          "responses": {
            "default": {
              "statusCode": "200",
              "responseParameters": {
                "method.response.header.content-type": "'application/json'"
              }
            }
          },
          "requestParameters": {
            "integration.request.header.Authorization": "stageVariables.omsAuthToken"
          },
          "passthroughBehavior": "when_no_match",
          "timeoutInMillis": ${timeout},
          "connectionType": "VPC_LINK",
          "connectionId": "${stageVariables.vpcLinkId}",
          "httpMethod": "POST",
          "requestTemplates": {
            "application/json": "{\"SKU\":[]}"
          },
          "type": "http_proxy"
        }
      }
    },
    "/productavailability": {
      "post": {
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "200 response",
            "schema": {
              "$ref": "#/definitions/Empty"
            },
            "headers": {
              "content-type": {
                "type": "string"
              }
            }
          }
        },
        "security": [
          {
            "sigv4": []
          }
        ],
        "x-amazon-apigateway-integration": {
          "uri": "https://${stageVariables.albFriendlyHostname}/smcfs/restapi/executeFlow/getProductAvailability",
          "responses": {
            "default": {
              "statusCode": "200",
              "responseParameters": {
                "method.response.header.content-type": "'application/json'"
              }
            }
          },
          "requestParameters": {
            "integration.request.header.Authorization": "stageVariables.omsAuthToken"
          },
          "passthroughBehavior": "when_no_templates",
          "timeoutInMillis": ${timeout},
          "httpMethod": "POST",
          "type": "http_proxy",
          "connectionType": "VPC_LINK",
          "connectionId": "${stageVariables.vpcLinkId}"
        }
      }
    },
    "/reserveinventory": {
      "post": {
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "200 response",
            "schema": {
              "$ref": "#/definitions/Empty"
            },
            "headers": {
              "content-type": {
                "type": "string"
              }
            }
          }
        },
        "security": [
          {
            "sigv4": []
          }
        ],
        "x-amazon-apigateway-integration": {
          "uri": "https://${stageVariables.albFriendlyHostname}/smcfs/restapi/executeFlow/reserveInventorySync",
          "responses": {
            "default": {
              "statusCode": "200",
              "responseParameters": {
                "method.response.header.content-type": "'application/json'"
              }
            }
          },
          "requestParameters": {
            "integration.request.header.Authorization": "stageVariables.omsAuthToken",
            "integration.request.header.X-XAPI-Tag": "'Promise'"
          },
          "passthroughBehavior": "when_no_templates",
          "timeoutInMillis": ${timeout},
          "httpMethod": "POST",
          "type": "http_proxy",
          "connectionType": "VPC_LINK",
          "connectionId": "${stageVariables.vpcLinkId}"
        }
      }
    }
  },
  "securityDefinitions": {
    "sigv4": {
      "type": "apiKey",
      "name": "Authorization",
      "in": "header",
      "x-amazon-apigateway-authtype": "awsSigv4"
    }
  },
  "definitions": {
    "Empty": {
      "type": "object",
      "title": "Empty Schema"
    }
  },
  "x-amazon-apigateway-policy": {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::${aws_account_id}:user/omsproxy-${env_name}/omsproxy-${env_name}-atg-apigw-user",
            "arn:aws:iam::${aws_account_id}:user/omsproxy-${env_name}/omsproxy-${env_name}-midtier-apigw-user"
          ]
        },
        "Action": "execute-api:Invoke",
        "Resource": [
          "arn:aws:execute-api:${region}:${aws_account_id}:*/${env_name}/POST/*"
        ]
      }
    ]
  }
}
