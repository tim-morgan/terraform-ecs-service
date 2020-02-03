# Set up Task Execution Role
# ECS task execution role data
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "apisvc_ecsTaskExecutionRole_secrets" {
    statement {
        effect    = "Allow"
        actions   = [ "ssm:GetParameters" ]
        resources = [ "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/*" ]
    }
    statement {
        effect    = "Allow"
        actions   = [ "logs:CreateLogStream", "logs:PutLogEvents", "logs:CreateLogGroup" ]
        resources = [ "*" ]
    }
    /*statement {
        effect    = "Allow"
        actions   = [ "kms:Decrypt" ]
        resources = [ local.deploy_key_arn ]
    }*/
}

# Resources
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecsTaskExecutionRole-1"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
  tags = var.tags
}

resource "aws_iam_role_policy" "apisvc_ecsTaskExecutionRole_secrets" {
    name = "secrets-role"
    role        = aws_iam_role.ecs_task_execution_role.id
    policy      = data.aws_iam_policy_document.apisvc_ecsTaskExecutionRole_secrets.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
