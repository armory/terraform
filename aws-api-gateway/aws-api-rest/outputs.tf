output "api_gw_id" {
  value = "${aws_api_gateway_rest_api.api_gw.id}"
}

output "api_gw_id_root" {
  value = "${aws_api_gateway_rest_api.api_gw.root_resource_id}"
}

output "vpc_link_id" {
  value = "${aws_api_gateway_vpc_link.vpc_link.id}"
}

output "api_gw_model_name" {
  value = "${aws_api_gateway_model.api_gw_model.name}"
}

output "api_gw_validator_id" {
  value = "${aws_api_gateway_request_validator.validator.id}"
}

