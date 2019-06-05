# AWS API Integration

## API Gateway Use Case

API Gateway is managed AWS service that allows users to create a RESTful API that will act as a front door for services such as Spinnaker Gate.  For this particular use case, the API Gateway is used to receive request from external services services such as CircleCI or Github.  When a request is received by API Gateway, it is proxied back to Spinnaker Gate which lives on a private subnet over a VPC private link.  

API Gateway can be deployed using different endpoint types.  In this scenario we will use a `private` endpoint type.  

#### Module AWS API Endpoint

This Terraform scripts will perform the following:

1. Create an api key
2. Create an usage plan
3. Associate an api key to stage

### Prerequisites

The following parameters are needed prior to getting started:

* **Api Gateway Id** - Api to associate api-key
* **Stage Name** - Name of the stage where api-key is going to be used

## How To Use

Provide the values in [variables.tf] to suit your environment.

  `api_gw_id` - Api Gateway Id
  `stage_name` - Stage name

  ```bash
  # Initialize Terraform
  terraform init

  # Check to make sure script will do what you think it will do.
  terraform plan

  # Apply changes
  terraform apply
  ```
Or you can opt to call it as a module

``` 
module "api-gateway-rest" {
  source          = "git@github.com:armory/terraform.git//aws-api-gateway/aws-api-key"
}
```

Output values

  `api_key`
