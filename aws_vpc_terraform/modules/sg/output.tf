output "WebSecurityGroup" {
  value = aws_security_group.webSecurityGroup.id
}

output "DBSecurityGroup" {
  value = aws_security_group.dbSecurityGroup.id
}