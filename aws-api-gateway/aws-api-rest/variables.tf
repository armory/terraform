variable "api_gw_name" {
  default = "spin-prod-api-gw"
  type    = "string"
}

variable "api_description" {
  type    = "string"
}

variable "vpc_link_name" {
  default = "spin-gate-nlb"
  type    = "string"
}

variable "nlb_arn" {
  type    = "string"
}

variable "api_gw_model_name" {
  default = "Spinmodel"
  type    = "string"
}
 
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