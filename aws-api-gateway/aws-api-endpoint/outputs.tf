output "stage_name" {
  value = "${aws_api_gateway_deployment.api_deployment.stage_name}"
}

output "invoke_url" {
  value = "${aws_api_gateway_deployment.api_deployment.invoke_url}"
}