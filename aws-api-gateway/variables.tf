variable "api_gw_name" {
  default = "spin-prod-api-gw"
  type    = "string"
}

variable "api_description" {
  default = "<<Add some description here>>"
  type    = "string"
}

variable "stage_name" {
  default = "test"
  type    = "string"
}

variable "api_path_part" {
  default = "spinnaker"
  type    = "string"
}

# Spinnaker endpoint which triggers a pipeline
variable "uri_name" {
  default = "<<Add webhook URL here>>"
  type    = "string"
}

variable "vpc_link_name" {
  default = "spin-gate-nlb"
  type    = "string"
}

variable "nlb_arn" {
  default = "<<Add NLB ARN Here>>"
  type    = "string"
}

# Model name of the request
variable "api_gw_model_name" {
  default = "Spinmodel"
  type    = "string"
}
 
# In order receive parameters in spinnaker,
# add the parameters inside an object called parameters inside the properties object.
/*Example
"parameters": { 
          "type": "object" ,
          "properties": {
            "field1": { "type": "string" },
            "field2": { "type": "bool" }
          },
          "required": ["field1"]
  }
*/
variable "api_gw_model" {
  default = <<EOF
  {
    "$schema": "http://json-schema.org/draft-04/schema#",
    "title": "spinmodel",
    "type": "object",
    "properties": {
    
    }
  }
  EOF
  type    = "string"
}

# Enable/disabled  parameter validation in the request
variable "api_validate_parameters" {
  default = "false"
  type    = "string"
}

# Enable/disabled body validation in the request
variable "api_validate_body" {
  default = "false"
  type    = "string"
}