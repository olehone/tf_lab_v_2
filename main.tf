# module "s3" {
#   source      = "./modules/s3"
#   bucket_name = "terraform-state"
# }


# resource "null_resource" "method-delay" {
#   provisioner "local-exec" {
#     command = "sleep 5"
#   }
#   triggers = {
#     response = aws_api_gateway_resource.courses.id
#   }
# }

module "dynamo_db_courses" {
  source      = "./modules/dynamodb/eu-central-1"
  context     = module.label.context
  name        = "courses"
}

module "dynamo_db_authors" {
  source      = "./modules/dynamodb/eu-central-1"
  context     = module.label.context
  name        = "authors"
}



module "iam" {
    source = "./modules/iam/eu-central-1"
    context = module.label.context
    name = "iam"
    table_authors_arn = module.dynamo_db_authors.table_arn
    table_courses_arn = module.dynamo_db_courses.table_arn
}


module "lambda" {
  source = "./modules/lambda/eu-central-1"
  context = module.label.context
  get_all_authors_name = "get-all-authors"
  get_all_courses_name = "get-all-courses"
  get_course_name = "get-course"
  post_course_name = "post-course"
  update_course_name = "update-course"
  delete_course_name = "delete-course"
  table_authors_name = module.dynamo_db_authors.table_name
  table_authors_arn = module.dynamo_db_authors.table_arn
  table_courses_name = module.dynamo_db_courses.table_name
  table_courses_arn = module.dynamo_db_courses.table_arn
  lambda_get_all_authors_role_arn = module.iam.table_get_all_authors_role_arn
  lambda_get_all_courses_role_arn = module.iam.table_get_all_courses_role_arn
  lambda_get_course_role_arn = module.iam.table_get_course_role_arn
  lambda_post_course_role_arn = module.iam.table_put_course_role_arn
  lambda_update_course_role_arn = module.iam.table_put_course_role_arn //table_update_course_role_arn
  lambda_delete_course_role_arn = module.iam.table_delete_course_role_arn
}

#get all authors


# module "api_post_gateway"{
#   source = "./modules/apigw/eu-central-1"
#   context = module.label.context
#   name = "apigw"
#   # aws_api_gateway_rest_api_id = aws_api_gateway_rest_api.this.id
#   # aws_api_gateway_rest_api_execution_arn = aws_api_gateway_rest_api.this.execution_arn
#   aws_api_gateway_rest_api = aws_api_gateway_rest_api.this
#   method_type = "POST"
#   lambda_function_name = module.lambda.lambda_post_course_function_name
#   lambda_invoke_arn = module.lambda.lambda_post_course_invoke_arn
#   path_part = "post_course"
# }