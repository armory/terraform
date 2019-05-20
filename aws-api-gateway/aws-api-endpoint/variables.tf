variable "stage_name" {
  type    = "string"
}

variable "api_path_part" {
  type    = "string"
}

# Spinnaker endpoint which triggers a pipeline
variable "uri_name" {
  type    = "string"
}
######
variable "api_gw_id" {
  type    = "string"
}

variable "api_gw_id_root" {
  type    = "string"
}

variable "vpc_link_id" {
  type    = "string"
}

variable "api_gw_model_name" {
  type    = "string"
}

variable "api_gw_validator_id" {
  type    = "string"
}
