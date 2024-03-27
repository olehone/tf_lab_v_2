output "lambda_authors_invoke_arn" {
    value = module.lambda_get_all_authors.lambda_function_invoke_arn
}

output "lambda_authors_function_name" {
    value = module.lambda_get_all_authors.lambda_function_name
}
output "lambda_get_all_courses_invoke_arn" {
    value = module.lambda_get_all_courses.lambda_function_invoke_arn
}

output "lambda_get_all_courses_function_name" {
    value = module.lambda_get_all_courses.lambda_function_name
}

