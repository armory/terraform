

resource "aws_api_gateway_resource" "api_gw_resource" {
  rest_api_id               = "${var.api_gw_id}"
  parent_id                 = "${var.api_gw_id_root}"
  path_part                 = "${var.api_path_part}"
}

resource "aws_api_gateway_method" "api_gw_method_post" {
  rest_api_id               = "${var.api_gw_id}"
  resource_id               = "${aws_api_gateway_resource.api_gw_resource.id}"
  http_method               = "POST"
  authorization             = "NONE"
  api_key_required          = true
  request_validator_id      = "${var.api_gw_validator_id}"
  request_models = {
    "application/json" = "${var.api_gw_model_name}"
  }
  request_parameters = {
    "method.request.path.proxy" = false
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id               = "${var.api_gw_id}"
  resource_id               = "${aws_api_gateway_resource.api_gw_resource.id}"
  http_method               = "${aws_api_gateway_method.api_gw_method_post.http_method}"
  type                      = "HTTP"
  integration_http_method   = "POST"
  passthrough_behavior      = "WHEN_NO_MATCH"
  content_handling          = "CONVERT_TO_TEXT"
  uri                       = "${var.uri_name}"
  connection_type           = "VPC_LINK"
  connection_id             = "${var.vpc_link_id}"
}

resource "aws_api_gateway_method_response" "api_gw_method_response" {
  rest_api_id   = "${var.api_gw_id}"
  resource_id   = "${aws_api_gateway_resource.api_gw_resource.id}"
  http_method   = "${aws_api_gateway_method.api_gw_method_post.http_method}"
  status_code   = 200
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "integration_response" {
  depends_on = ["aws_api_gateway_integration.integration"]

  rest_api_id   = "${var.api_gw_id}"
  resource_id   = "${aws_api_gateway_resource.api_gw_resource.id}"
  http_method   = "${aws_api_gateway_method.api_gw_method_post.http_method}"
  status_code = "${aws_api_gateway_method_response.api_gw_method_response.status_code}"
  
  response_templates {
    "application/json" = ""
  }
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on                = ["aws_api_gateway_integration.integration"]
  
  rest_api_id               = "${var.api_gw_id}"
  stage_name                = "${var.stage_name}"
}
