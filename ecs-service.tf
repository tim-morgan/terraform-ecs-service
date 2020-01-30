resource "aws_ecs_service" "service" {
  name            = "${var.project_name}_${var.environment}_service"
  cluster         = var.cluster
  task_definition = aws_ecs_task_definition.task-definition.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target-group.id
    container_name   = "http"
    container_port   = var.port
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_lb_listener_rule.lb_listener_rule]
}
