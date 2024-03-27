resource "aws_api_gateway_rest_api" "this" {
    name = module.label_api.id

    endpoint_configuration {
        types = ["REGIONAL"]
    }
}

###############################
#GET AUTHORS

resource "aws_lambda_permission" "allow_api_gateway_authors" {
  statement_id  = "AllowExecutionFromAPIGateWay"
  action        = "lambda:InvokeFunction"
  function_name =  module.lambda.lambda_authors_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET${aws_api_gateway_resource.authors.path}"
}

resource "aws_api_gateway_resource" "authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    parent_id = aws_api_gateway_rest_api.this.root_resource_id
    path_part = "authors"
}

resource "aws_api_gateway_method" "get_authors" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.authors.id
    http_method   = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.authors.id
    http_method = aws_api_gateway_method.get_authors.http_method
    integration_http_method = "POST"
    type = "AWS"
    uri = module.lambda.lambda_authors_invoke_arn
    request_parameters = {"integration.request.header.X-Authorization" = "'static'"}
    request_templates = {
        "application/xml" = <<EOF
        {
            "body" : $input.json('$')
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.authors.id
    http_method = aws_api_gateway_method.get_authors.http_method
    status_code = "200"
    response_models = {"application/json" = "Empty"}
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = true,
      "method.response.header.Access-Control-Allow-Methods" = true,
      "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "get_authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.authors.id
    http_method = aws_api_gateway_method.get_authors.http_method
    status_code = aws_api_gateway_method_response.get_authors.status_code
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
      "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}


###############################
#GET COURSES

resource "aws_lambda_permission" "allow_api_gateway_courses" {
  statement_id  = "AllowExecutionFromAPIGateWay"
  action        = "lambda:InvokeFunction"
  function_name =  module.lambda.lambda_get_all_courses_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET${aws_api_gateway_resource.courses.path}"
}

resource "aws_api_gateway_resource" "courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    parent_id = aws_api_gateway_rest_api.this.root_resource_id
    path_part = "courses"
}

resource "aws_api_gateway_method" "get_courses" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.courses.id
    http_method   = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.authors.id
    http_method = aws_api_gateway_method.get_courses.http_method
    integration_http_method = "POST"
    type = "AWS"
    uri = module.lambda.lambda_get_all_courses_invoke_arn
    request_parameters = {"integration.request.header.X-Authorization" = "'static'"}
    request_templates = {
        "application/xml" = <<EOF
        {
            "body" : $input.json('$')
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.courses.id
    http_method = aws_api_gateway_method.get_courses.http_method
    status_code = "200"
    response_models = {"application/json" = "Empty"}
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = true,
      "method.response.header.Access-Control-Allow-Methods" = true,
      "method.response.header.Access-Control-Allow-Origin" = false
    }
    depends_on = [ aws_api_gateway_resource.courses ]
}

resource "aws_api_gateway_integration_response" "get_courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.courses.id
    http_method = aws_api_gateway_method.get_courses.http_method
    status_code = aws_api_gateway_method_response.get_courses.status_code
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
      "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }

    depends_on = [ aws_api_gateway_integration.get_courses ]
}