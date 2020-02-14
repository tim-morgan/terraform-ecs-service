# outputs

output "security_group_id" {
    description = "The Security Group for the ECS tasks."
    value = aws_security_group.ecs_tasks.id
}