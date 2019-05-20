# AWS API Integration

## API Gateway Use Case

API Gateway is managed AWS service that allows users to create a RESTful API that will act as a front door for services such as Spinnaker Gate.  For this particular use case, the API Gateway is used to receive request from external services services such as CircleCI or Github.  When a request is received by API Gateway, it is proxied back to Spinnaker Gate which lives on a private subnet over a VPC private link.  

API Gateway can be deployed using different endpoint types.  In this scenario we will use a `private` endpoint type.  

This Terraform scripts will perform the following:

1. Create API Gateway with private endpoint
2. Create a resource
3. Creates a `POST` method
4. Create a `VPC Link` with proxy integration
5. Create a deployment stage
6. Create a VPC Link
7. Create a Usage Plan 
8. Create an Api key
9. Create a request model 

### Prerequisites

The following parameters are needed prior to getting started:

* **URI** - This will be the URI of the webhook
* **ARN** of the network load balancer - This will be the ARN of the target NLB that sits in front of Gate.

## How To Use

Modify the values in [variables.tf] to suit your environment.

  `api_gw_name`
  `api_description`
  `stage_name`
  `api_path_part`
  `uri_name`
  `vpc_link_name`
  `nlb_arn`
  `api_gw_model_name`
  `api_gw_model`
  `api_validate_parameters`
  `api_validate_body`

  ```bash
  # Initialize Terraform
  terraform init

  # Check to make sure script will do what you think it will do.
  terraform plan

  # Apply changes
  terraform apply
  ```
