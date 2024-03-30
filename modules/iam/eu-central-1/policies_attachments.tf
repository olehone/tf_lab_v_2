resource "aws_iam_role_policy_attachment" "read_table_authors" {
  role       = aws_iam_role.read_table_authors.name
  policy_arn = aws_iam_policy.read_table_authors.arn
}

# resource "aws_iam_role_policy_attachment" "get_author" {
#   role       = aws_iam_role.label_table_authors.name
#   policy_arn = aws_iam_policy.get_author.arn
# }

# resource "aws_iam_role_policy_attachment" "put_author" {
#   role       = aws_iam_role.label_table_authors.name
#   policy_arn = aws_iam_policy.put_author.arn
# }

# resource "aws_iam_role_policy_attachment" "update_author" {
#   role       = aws_iam_role.label_table_authors.name
#   policy_arn = aws_iam_policy.update_author.arn
# }

# resource "aws_iam_role_policy_attachment" "delete_author" {
#   role       = aws_iam_role.label_table_authors.name
#   policy_arn = aws_iam_policy.delete_author.arn
# }

resource "aws_iam_role_policy_attachment" "read_table_courses" {
  role       = aws_iam_role.read_table_courses.name
  policy_arn = aws_iam_policy.read_table_courses.arn
}

resource "aws_iam_role_policy_attachment" "get_course" {
  role       = aws_iam_role.get_course.name
  policy_arn = aws_iam_policy.get_course.arn
}

resource "aws_iam_role_policy_attachment" "put_course" {
  role       = aws_iam_role.put_course.name
  policy_arn = aws_iam_policy.put_course.arn
}

resource "aws_iam_role_policy_attachment" "update_course" {
  role       = aws_iam_role.update_course.name
  policy_arn = aws_iam_policy.update_course.arn
}

resource "aws_iam_role_policy_attachment" "delete_course" {
  role       = aws_iam_role.delete_course.name
  policy_arn = aws_iam_policy.delete_course.arn
}
