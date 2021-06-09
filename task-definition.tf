resource "aws_ecs_task_definition" "task-definition" {
    family                   = "${var.project_name}_${var.environment}_task"
    execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
    network_mode             = "awsvpc"
    cpu                      = var.task_def_cpu_limit
    memory                   = var.task_def_memory_limit
    requires_compatibilities = ["FARGATE"]
    container_definitions    = var.container_definition
    
    dynamic "volume" {
        for_each = var.volumes

        content {
            name = volume.value
        }
    }

    tags = var.tags
}


