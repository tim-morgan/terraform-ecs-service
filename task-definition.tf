resource "aws_ecs_task_definition" "task-definition" {
    family                   = "${var.project_name}_${var.environment}_task"
    execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
    network_mode             = "awsvpc"
    cpu                      = "256"
    memory                   = "512"
    requires_compatibilities = ["FARGATE"]
    container_definitions    = var.container_definition
}